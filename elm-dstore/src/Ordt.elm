module Ordt exposing (..)

{-| Operational Replicated Data Type

This implementation comes from [this blogpost](http://archagon.net/blog/2018/03/24/data-laced-with-history/).

This module should only be used to implement custom ORDTs. You might want to use an `elm-review` rule to enforce this.

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


{-| Unique identifier for a copy of the data structure.

NB: This uid should never be shared even amongst different data structures.
-}
type CopyUid
    = CopyUid UUID


{-| Operational Replicated Data Type
-}
type Ordt op
    = Ordt
        { copyUid : CopyUid

        -- highest logical time currently in the ORDT
        , now : LogicalTime

        -- Weave : retrieve data in O(n) but retrieve specific Atom in O(n)
        -- original copy at logical time zero is the initial atom and the causalTree points every cause to its effects
        , originalCopy : CopyUid
        , causalTree : GDict AtomUid (GDict AtomUid op)

        -- Yarn : retrieve specific Atom in O(1) but data in O(n^2)
        -- atoms is a map of all atoms by copyUid
        , atoms : GDict CopyUid (GDict LogicalTime (Atom op))

        -- Cache : lazy evaluation
        -- , cache : Maybe data
        --
        -- UUIDs are 4 ints long and are duplicated for every atom and each atom is stored twice in the causalTree and in the atoms table. This gets heavy quick.
        -- The idea here is to replace those heavy UUIDs with a single int and store the correspondence in the Ordt
        -- , shortMapping : GBiDict CopyUid ShortCopyUid
        --
        -- We also want to store a prolly tree of the atoms to get fast diffs and improve syncing between clients
        -- see https://www.youtube.com/watch?v=X8nAdx1G-Cs
        }


{-| unique version vector
-}
type Weft
    = Weft (GDict CopyUid LogicalTime)

new : Generator (Ordt op)
new =
    Random.map init newCopyUid


newCopyUid : Generator CopyUid
newCopyUid =
    Random.map CopyUid UUID.generator

init : CopyUid -> Ordt op
init copyUid_ =
    { copyUid = copyUid_
    , now = LogicalTime.zero
    , originalCopy = copyUid_
    , causalTree = GDict.empty
    , atoms = GDict.empty
    }
        |> Ordt

isEmpty : Ordt op -> Bool
isEmpty (Ordt { causalTree }) =
    GDict.isEmpty causalTree


root : Ordt op -> AtomUid
root (Ordt ordt) =
    { logicalTime = LogicalTime.zero
    , copyUid = ordt.originalCopy
    }
        |> AtomUid

copyUid : Ordt op -> CopyUid
copyUid (Ordt ordt) =
    ordt.copyUid

{-| builds the ordt from its copyUid, its root and a list of atoms.
Returns nothing if any atomUid is invalid (not unique, disconnected from root, caused by a higher logical time or root isn't at logical time zero).
-}
build : CopyUid -> AtomUid -> List ( AtomUid, op ) -> Maybe (Ordt op)
build copyUid_ root_ log =
    Debug.todo "Ordt.build"

toLog : Ordt op -> List ( AtomUid, op )
toLog (Ordt ordt) =
    Debug.todo "Ordt.toLog"

{-| Merge two ORDTs having the same root.
Keep the copyUid of the second.
Return Nothing if the roots are different.
-}
merge : Ordt op -> Ordt op -> Maybe (Ordt op)
merge (Ordt a) (Ordt b) =
    if a.originalCopy /= b.originalCopy then
        Nothing

    else
        { copyUid = b.copyUid
        , now = LogicalTime.max a.now b.now
        , originalCopy = b.originalCopy
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
                (\( copyUid_, atoms ) ->
                    GDict.update copyUidToComparable
                        copyUid_
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
                cause
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
atomUidToComparable (AtomUid atomUid) =
    LogicalTime.toComparable atomUid.logicalTime :: copyUidToComparable atomUid.copyUid


copyUidToComparable : CopyUid -> List Int
copyUidToComparable (CopyUid uuid) =
    UUID.toComparable uuid


logicalTimeToComparable : LogicalTime -> List Int
logicalTimeToComparable =
    LogicalTime.toComparable >> List.singleton
