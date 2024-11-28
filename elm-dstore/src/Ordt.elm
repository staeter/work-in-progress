module Ordt exposing (..)

{-| Operational Replicated Data Type

This implementation comes from [this blogpost](http://archagon.net/blog/2018/03/24/data-laced-with-history/).

-}

import GDict
import LogicalTime exposing (LogicalTime)
import Random exposing (Generator)
import UUID exposing (UUID)


{-| Atomic change to the data structure. Immutable and has a globally unique id (AtomUid).
-}
type alias Atom op =
    { cause : AtomUid -- atom onto which this operation builds upon
    , operation : op
    }


type AtomUid
    = AtomUid
        { logicalTime : LogicalTime
        , copyUid : CopyUid
        }


{-| Unique identifier for a copy of the data structure
-}
type CopyUid
    = CopyUid UUID


{-| Operational Replicated Data Type
-}
type Ordt op
    = Ordt
        { copyUid : CopyUid
        , now : LogicalTime

        -- Weave : retrieve data in O(n) but retrieve specific Atom in O(n)
        , root : AtomUid
        , causalTree : GDict AtomUid (GDict AtomUid op)

        -- Yarn : retrieve specific Atom in O(1) but data in O(n^2)
        , atoms : GDict CopyUid (GDict LogicalTime (Atom op))

        -- Cache : lazy evaluation
        -- , cache : Maybe data
        }


{-| unique version vector
-}
type Weft
    = Weft (GDict CopyUid LogicalTime)


empty : Generator (Ordt op)
empty =
    Random.map
        (\copyUid ->
            { copyUid = CopyUid copyUid
            , now = LogicalTime.zero
            , root =
                { logicalTime = LogicalTime.zero
                , copyUid = CopyUid copyUid
                }
                    |> AtomUid
            , causalTree = GDict.empty
            , atoms = GDict.empty
            }
                |> Ordt
        )
        UUID.generator


isEmpty : Ordt op -> Bool
isEmpty (Ordt { causalTree }) =
    GDict.isEmpty causalTree


root : Ordt op -> AtomUid
root (Ordt ordt) =
    ordt.root


{-| Merge two ORDTs having the same root.
Keep the copyUid of the second.
Return Nothing if the roots are different.
-}
merge : Ordt op -> Ordt op -> Maybe (Ordt op)
merge (Ordt a) (Ordt b) =
    if a.root /= b.root then
        Nothing

    else
        { copyUid = b.copyUid
        , now = LogicalTime.max a.now b.now
        , root = b.root
        , causalTree =
            List.foldl
                (\( id, ops ) ->
                    GDict.update atomUidToComparable
                        id
                        (Maybe.map (GDict.union ops)
                            >> Maybe.withDefault ops
                            >> Just
                        )
                )
                a.causalTree
                (GDict.toList b.causalTree)
        , atoms =
            List.foldl
                (\( copyUid, atoms ) ->
                    GDict.update copyUidToComparable
                        copyUid
                        (Maybe.map (GDict.union atoms)
                            >> Maybe.withDefault atoms
                            >> Just
                        )
                )
                a.atoms
                (GDict.toList b.atoms)
        }
            |> Ordt
            |> Just


{-| Insert an operation after its causal atom and returns its uid
-}
insertAfter : AtomUid -> op -> Ordt op -> ( AtomUid, Ordt op )
insertAfter cause op (Ordt ordt) =
    let
        logicalTime =
            LogicalTime.increment ordt.now

        atomUid =
            { logicalTime = logicalTime
            , copyUid = ordt.copyUid
            }
                |> AtomUid

        atom =
            { cause = cause
            , operation = op
            }
    in
    { ordt
        | now = logicalTime
        , causalTree =
            GDict.update atomUidToComparable
                ordt.root
                (Maybe.map (GDict.insert atomUidToComparable atomUid op)
                    >> Maybe.withDefault (GDict.singleton atomUidToComparable atomUid op)
                    >> Just
                )
                ordt.causalTree
        , atoms =
            GDict.update copyUidToComparable
                ordt.copyUid
                (Maybe.map (GDict.insert logicalTimeToComparable logicalTime atom)
                    >> Maybe.withDefault (GDict.singleton logicalTimeToComparable logicalTime atom)
                    >> Just
                )
                ordt.atoms
    }
        |> Ordt
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



-- To Comparable --


type alias GDict k v =
    GDict.GDict (List Int) k v


atomUidToComparable : AtomUid -> List Int
atomUidToComparable (AtomUid { logicalTime, copyUid }) =
    LogicalTime.toComparable logicalTime :: copyUidToComparable copyUid


copyUidToComparable : CopyUid -> List Int
copyUidToComparable (CopyUid uuid) =
    UUID.toComparable uuid


logicalTimeToComparable : LogicalTime -> List Int
logicalTimeToComparable =
    LogicalTime.toComparable >> List.singleton
