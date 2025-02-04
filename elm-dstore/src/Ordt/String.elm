module Ordt.String exposing (..)

import DiffBy
import GDict
import Ordt exposing (AtomUid, Ordt(..), CopyUid)
import Random exposing (Generator)


{-| Operations that build up the ORDT String

The causal link is made with the character to the right to avoid String.reverse and List.reverse on weave.
Therefore the root atom represents the end of the string.

-}
type Op
    = InsertLeft Char
    | Tombstone


type alias DString =
    Ordt Op


weave : DString -> String
weave ((Ordt { causalTree }) as ordt) =
    let
        root = Ordt.root ordt

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


{-| Create a DString from a string.

The generator is needed to for the copyUid to be unique
-}
fromString : String -> Generator DString
fromString str =
    Random.map (\copyUid -> build copyUid str) Ordt.newCopyUid


{-| count the amount of chars in the string -}
count : DString -> Int
count (Ordt { atoms }) =
    List.foldl
        (\( _, atomsByLogicalTime ) acc ->
            List.foldl
                (\ ( _, atom) acc_ ->
                    case atom.operation of
                        InsertLeft _ ->
                            acc_ + 1

                        Tombstone ->
                            acc_ - 1
                )
                acc
                (GDict.toList atomsByLogicalTime)
        )
        0
        (GDict.toList atoms)


{-| make the diff between the string and the ordt and insert changes into the ordt
-}
insertDiff : String -> DString -> DString
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


toList : DString -> List ( AtomUid, Char )
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
    traverseTree (Ordt.root (Ordt ordt)) []


{-| This should only be used to design custom ORDTs containing DStrings -}
build : CopyUid -> String -> DString
build copyUid str =
    let
        ordt =
            Ordt.init copyUid
    in
    Ordt.insertSeriesAfter
        (Ordt.root ordt)
        (List.map InsertLeft <| List.reverse <| String.toList str)
        ordt
