module Test.Ordt exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer)
import Test exposing (Test)
import Ordt exposing (..)

dummyCopyUid : CopyUid
dummyCopyUid =
    CopyUid 420

dummyOrdtUid : OrdtUid
dummyOrdtUid =
    OrdtUid (CopyUid 236)

copyUidFuzzer : Fuzzer CopyUid
copyUidFuzzer =
    Fuzz.fromGenerator Ordt.copyUidGenerator

ordtUidFuzzer : Fuzzer OrdtUid
ordtUidFuzzer =
    Fuzz.map OrdtUid Ordt.copyUidGenerator

suite :
    { name : String
    , exampleData : List data
    , fromData : OrdtUid -> CopyUid -> data -> Ordt op
    , weave : Ordt op -> data
    , operations : List (Fuzzer (Ordt op -> Ordt op))
    }
    -> Test
suite { name, exampleData, weave, fromData, operations } =
    let
        operationListFuzzer : Fuzzer (List (Ordt op -> Ordt op))
        operationListFuzzer =
            Fuzz.oneOf list operations
            |> Fuzz.listOfLengthBetween 2 100

        operationListWithDifferentOrderingsFuzzer : Fuzzer (List (Ordt op -> Ordt op), List (Ordt op -> Ordt op))
        operationListWithDifferentOrderingsFuzzer =
            Fuzz.andThen
                (\ list ->
                    Fuzz.pair
                        (Fuzz.constant list)
                        (Fuzz.shuffledList list)
                )
                operationListFuzzer
    in
    [ List.indexedMap
        (\index data ->
            test ("Build then Weave " ++ name ++ " " ++ String.fromInt index)
                ( \() ->
                    fromData dummyOrdtUid dummyCopyUid data
                    |> weave
                    |> Expect.equal data
                )
        )
    , Test.fuzz2
        (Fuzz.oneOf exampleData)
        operationListWithDifferentOrderingsFuzzer
        ("Run operations on " ++ name ++ " in different orders")
        (\data (opListA, opListB) ->
            let
                originalOrdt = fromData dummyOrdtUid dummyCopyUid
            in
            Expect.equal
                (List.foldl (|>) originalOrdt opListA |> weave)
                (List.foldl (|>) originalOrdt opListB |> weave)
        )
        |> List.singleton
    ]
    |> List.concat
    |> describe (name ++ " Test Suite")
