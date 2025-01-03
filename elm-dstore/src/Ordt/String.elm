module Ordt.String exposing (..)

import DiffBy
import GDict
import Ordt exposing (Atom, AtomUid, GDict, Ordt(..))
import Random exposing (Generator)


{-| Operations that build up the ORDT String

The causal link is made with the character to the right to avoid String.reverse and List.reverse on weave.
Therefore the root atom represents the end of the string.

-}
type Op
    = InsertLeft Char
    | Tombstone


weave : Ordt Op -> String
weave (Ordt { root, causalTree }) =
    let
        findAndFilterTombstones : List ( AtomUid, Op ) -> ( Bool, List ( AtomUid, Op ) )
        findAndFilterTombstones ops =
            List.foldl
                (\( id, op ) ( found, acc ) ->
                    case op of
                        Tombstone ->
                            ( True, acc )

                        InsertLeft _ ->
                            ( found, ( id, op ) :: acc )
                )
                ( False, [] )
                ops

        traverseTree : AtomUid -> String -> String
        traverseTree id str =
            let
                ( isTombstone, branches ) =
                    GDict.get Ordt.atomUidToComparable id causalTree
                        |> Maybe.map GDict.toList
                        |> Maybe.withDefault []
                        |> findAndFilterTombstones
            in
            List.foldl
                (\( subId, op ) acc ->
                    case op of
                        InsertLeft c ->
                            traverseTree subId (String.cons c acc)

                        Tombstone ->
                            acc
                )
                (if isTombstone then
                    String.dropLeft 1 str

                 else
                    str
                )
                branches
    in
    traverseTree root ""


fromString : String -> Generator (Ordt Op)
fromString str =
    Random.map
        (\ordt ->
            Ordt.insertSeriesAfter
                (Ordt.root ordt)
                (List.map InsertLeft <| String.toList str)
                ordt
        )
        Ordt.empty


length : Ordt Op -> Int
length (Ordt { causalTree }) =
    let
        countChars : GDict AtomUid Op -> Int
        countChars branches =
            List.foldl
                (\( _, op ) acc ->
                    case op of
                        Tombstone ->
                            { acc | tombstone = True }

                        InsertLeft _ ->
                            { acc | count = acc.count + 1 }
                )
                { tombstone = False, count = 0 }
                (GDict.toList branches)
                |> (\{ tombstone, count } ->
                        count
                            - (if tombstone then
                                1

                               else
                                0
                              )
                   )
    in
    List.foldl
        (\( _, branches ) acc ->
            acc + countChars branches
        )
        0
        (GDict.toList causalTree)


{-| make the diff between the string and the ordt and insert changes into the ordt
-}
insertDiff : String -> Ordt Op -> Ordt Op
insertDiff str ordt =
    let
        changes =
            DiffBy.diffBy
                Tuple.second
                identity
                (toList ordt)
                (String.toList str)

        recursiveUpdate changes_ addedList ordtAcc =
            let
                insertAddedListAfter atomUid =
                    Ordt.insertSeriesAfter
                        atomUid
                        (List.foldl
                            (\a acc ->
                                -- reverse and map to InsertLeft
                                InsertLeft a :: acc
                            )
                            []
                            addedList
                        )
            in
            case changes_ of
                [] ->
                    ordtAcc

                (DiffBy.Added c) :: queue ->
                    recursiveUpdate queue (c :: addedList) ordtAcc

                (DiffBy.NoChange ( atomUid, _ )) :: queue ->
                    insertAddedListAfter atomUid ordtAcc
                        |> recursiveUpdate queue []

                (DiffBy.Removed ( atomUid, _ )) :: queue ->
                    Ordt.insertAfter atomUid Tombstone ordtAcc
                        |> Tuple.second
                        |> insertAddedListAfter atomUid
                        |> recursiveUpdate queue []
    in
    recursiveUpdate changes [] ordt


toList : Ordt Op -> List ( AtomUid, Char )
toList (Ordt ordt) =
    let
        findAndFilterTombstones : List ( AtomUid, Op ) -> ( Bool, List ( AtomUid, Op ) )
        findAndFilterTombstones ops =
            List.foldl
                (\( id, op ) ( found, acc ) ->
                    case op of
                        Tombstone ->
                            ( True, acc )

                        InsertLeft _ ->
                            ( found, ( id, op ) :: acc )
                )
                ( False, [] )
                ops

        traverseTree : AtomUid -> List ( AtomUid, Char ) -> List ( AtomUid, Char )
        traverseTree id list =
            let
                ( isTombstone, branches ) =
                    GDict.get Ordt.atomUidToComparable id ordt.causalTree
                        |> Maybe.map GDict.toList
                        |> Maybe.withDefault []
                        |> findAndFilterTombstones
            in
            List.foldl
                (\( subId, op ) acc ->
                    case op of
                        InsertLeft c ->
                            traverseTree subId (( subId, c ) :: acc)

                        Tombstone ->
                            acc
                )
                (if isTombstone then
                    List.drop 1 list

                 else
                    list
                )
                branches
    in
    traverseTree ordt.root []
