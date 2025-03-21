module Test.Ordt.String exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Ordt exposing (..)
import Ordt.String
import Test.Ordt

suite : Test
suite =
    Test.Ordt.suite
        { name = "DString"
        , exampleData =
            [ "Hello, World!"
            , "This is a test"
            , "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            , ""
            , "a"
            ]
        , fromData = Ordt.String.fromString
        , weave = Ordt.String.weave
        , operations =
            [ Fuzz.map Ordt.String.insertDiff (Fuzz.stringOfLengthBetween 1 20)
            ]
        }
