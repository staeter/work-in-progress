module Ordt.String exposing (..)

import Dict exposing (Dict)
import Ordt exposing (Ordt)
import Ordt.Internal.String exposing (..)


type Op
    = Insert Char
    | Tombstone


weave : Ordt Op -> String
weave { root, causalTree } =
    let
        findAndFilterTombstones : List ( AtomUid, Op ) -> ( Bool, List ( AtomUid, Op ) )
        findAndFilterTombstones ops =
            List.foldl
                (\( id, op ) ( found, acc ) ->
                    case op of
                        Tombstone ->
                            ( True, acc )

                        _ ->
                            ( found, ( id, op ) :: acc )
                )
                ( False, [] )
                ops

        traverseTree : AtomUid -> String -> String
        traverseTree id str =
            let
                ( isTombstone, branches ) =
                    Dict.get id causalTree
                        |> Maybe.map Dict.toList
                        |> Maybe.withDefault []
                        |> findAndFilterTombstones
            in
            List.foldl
                (\subId op ->
                    case op of
                        Insert c ->
                            traverseTree subId (str ++ c)

                        Tombstone ->
                            str
                )
                (if isTombstone then
                    String.dropRight 1 str

                 else
                    str
                )
                branches
    in
    traverseTree root


fromString : String -> Ordt Op
fromString str =
    Debug.todo "Ordt.String.fromString"


length : Ordt Op -> Int
length { causalTree } =
    let
        countChars : Dict AtomUid Op -> Int
        countChars branches =
            List.foldl
                (\( _, op ) acc ->
                    case op of
                        Tombstone ->
                            { acc | tombstone = True }

                        Insert _ ->
                            { acc | count = acc.count + 1 }
                )
                { tombstone = False, count = 0 }
                (Dict.toList ops)
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
        (\( _, ops ) acc ->
            acc + countChars ops
        )
        0
        (Dict.toList causalTree)


{-| make the diff between the string and the ordt and insert changes into the ordt
-}
insertDiff : String -> Ordt Op -> Ordt Op
insertDiff str ordt =
    Debug.todo "Ordt.String.insertDiff"
