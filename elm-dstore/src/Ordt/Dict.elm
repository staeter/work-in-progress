module Ordt.Internal.Dict exposing (..)

import Ordt exposing (Ordt)


type Op key subOp
    = Insert key subOp
    | Update key subOp
    | Tombstone key


weave : (Ordt subOp -> data) -> Ordt (Op key subOp) -> Dict key data
weave =
    Debug.todo "Ordt.Dict.weave"
