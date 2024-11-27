module Ordt exposing (..)

{-| Operational Replicated Data Type

This implementation comes from [this blogpost](http://archagon.net/blog/2018/03/24/data-laced-with-history/).

-}

import Dict exposing (Dict)
import LogicalTime exposing (LogicalTime)


{-| Atomic change to the data structure. Immutable and has a globally unique id (AtomUid).
-}
type alias Atom op =
    { cause : AtomUid -- atom onto which this operation builds upon
    , operation : op
    }


type alias AtomUid =
    { logicalTime : LogicalTime
    , copyUid : CopyUid
    }


{-| Unique identifier for a copy of the data structure
-}
type CopyUid
    = CopyUid String


{-| Operational Replicated Data Type
-}
type alias Ordt op =
    { copyUid : CopyUid
    , now : LogicalTime

    -- Weave : retrieve data in O(n) but retrieve specific Atom in O(n)
    , root : AtomUid
    , causalTree : Dict AtomUid (Dict AtomUid op)

    -- Yarn : retrieve specific Atom in O(1) but data in O(n^2)
    , atoms : Dict CopyUid (Dict LogicalTime (Atom op))
    }


{-| unique version vector
-}
type Weft
    = Weft (Dict CopyUid LogicalTime)


empty : CopyUid -> Ordt op
empty copyUid =
    { copyUid = copyUid
    , now = LogicalTime.zero
    , root =
        { logicalTime = LogicalTime.zero
        , copyUid = copyUid
        }
    , causalTree = Dict.empty
    , atoms = Dict.empty
    }


isEmpty : Ordt op -> Bool
isEmpty { causalTree } =
    Dict.isEmpty causalTree


{-| Merge two ORDTs having the same root.
Keep the copyUid of the second.
Return Nothing if the roots are different.
-}
merge : Ordt op -> Ordt op -> Maybe (Ordt op)
merge a b =
    if a.root /= b.root then
        Nothing

    else
        { copyUid = b.copyUid
        , now = LogicalTime.max a.now b.now
        , root = b.root
        , causalTree =
            List.foldl
                (\( id, ops ) ->
                    Dict.update id
                        (Maybe.map (Dict.union ops)
                            |> Maybe.withDefault ops
                        )
                )
                a.causalTree
                (Dict.toList b.causalTree)
        , atoms =
            List.foldl
                (\( copyUid, atoms ) ->
                    Dict.update copyUid
                        (Maybe.map (Dict.union atoms)
                            |> Maybe.withDefault atoms
                        )
                )
                a.atoms
                (Dict.toList b.atoms)
        }


{-| Insert an operation after its causal atom and returns its uid
-}
insertAfter : AtomUid -> op -> Ordt op -> ( AtomUid, Ordt op )
insertAfter cause op { copyUid, now, root, causalTree, atoms } =
    let
        logicalTime =
            LogicalTime.increment now

        atomUid =
            { logicalTime = logicalTime
            , copyUid = copyUid
            }

        atom =
            { cause = cause
            , operation = op
            }
    in
    { copyUid = copyUid
    , now = logicalTime
    , root = root
    , causalTree =
        Dict.update root
            (Maybe.map (Dict.insert atomUid atom)
                |> Maybe.withDefault (Dict.singleton atomUid atom)
            )
            causalTree
    , atoms =
        Dict.update copyUid
            (Maybe.map (Dict.insert logicalTime atom)
                |> Maybe.withDefault (Dict.singleton logicalTime atom)
            )
            atoms
    }
        |> Tuple.pair atomUid


{-| Insert a list of operations as a causal series after the initial causal atom
-}
insertSeriesAfter : AtomUid -> List op -> Ordt op -> Ordt op
insertSeriesAfter cause ops ordt =
    List.foldl
        (\op ( previousUid, ordtAcc ) ->
            insertAfter previousUid op ordtAcc
        )
        ( cause, ordt )
        ops
        |> Tuple.second
