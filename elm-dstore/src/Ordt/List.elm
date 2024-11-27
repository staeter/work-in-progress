module Ordt.List exposing (..)

import Ordt exposing (Ordt)
import Ordt.Internal.List exposing (..)


type Op subOp
    = Insert subOp
    | Update subOp
    | Tombstone


weave : (Ordt subOp -> data) -> Ordt (Op subOp) -> List data
weave =
    Debug.todo "Ordt.List.weave"
