module Ordt.Log exposing (..)

import GDict
import Ordt exposing (AtomUid(..), Ordt(..), CopyUid)
import LogicalTime


{-| Operations that build up the ORDT Log

-}
type Op a
    = Push a


type alias DLog a =
    Ordt (Op a)


weave : DLog a -> List a
weave ((Ordt { causalTree }) as ordt) =
    let
        root = Ordt.root ordt

        traverseTree : AtomUid -> List a -> List a
        traverseTree id list =
            let
                branches =
                    GDict.get Ordt.atomUidToComparable id causalTree
                        |> Maybe.map GDict.toList
                        |> Maybe.withDefault []
            in
            List.foldl
                (\( subId, Push a ) acc ->
                    traverseTree subId (a :: acc)
                )
                list
                branches
    in
    traverseTree root []


{-| Create a DLog from a List with the original copyUid
-}
fromList : CopyUid -> AtomUid -> List a -> Maybe (DLog a)
fromList copyUid ((AtomUid {logicalTime}) as root) list =
    if LogicalTime.toComparable logicalTime /= 0 then
        Nothing
    else
        Ordt.insertSeriesAfter
            root
            (List.map Push list)
            (Ordt.init copyUid)
            |> Just


{-| count the amount of elements in the log -}
count : DLog a -> Int
count (Ordt { atoms }) =
    List.foldl
        (\( _, atomsByLogicalTime ) acc ->
            (GDict.toList atomsByLogicalTime |> List.length) + acc
        )
        0
        (GDict.toList atoms)
