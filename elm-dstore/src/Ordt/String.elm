module Ordt.String exposing (..)

import Ordt exposing (Ordt)
import Ordt.Internal.String exposing (..)


type Op
    = Insert Char
    | Tombstone


weave : Ordt Op -> String
weave =
    Debug.todo "Ordt.String.weave"
