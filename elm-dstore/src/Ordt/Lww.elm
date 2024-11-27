module Ordt.Lww exposing (..)

import Ordt exposing (Ordt)
import Ordt.Internal.Lww exposing (..)


type Op a
    = Push a


weave : (Ordt subOp -> data) -> Ordt (Op subOp) -> Lww data
weave =
    Debug.todo "Ordt.Lww.weave"
