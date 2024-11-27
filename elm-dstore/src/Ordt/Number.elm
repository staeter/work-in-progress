module Ordt.Internal.Number exposing (..)

import Ordt exposing (Ordt)


type Op number
    = Add number
    | Push number


weave : Ordt (Op number) -> number
weave =
    Debug.todo "Ordt.Number.weave"
