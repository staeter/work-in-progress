module Main exposing (LogicalTime, increment, max, zero)

{-| increase by one for every Atom emitted by the Site
-}


type LogicalTime
    = LogicalTime Int


zero : LogicalTime
zero =
    LogicalTime 0


increment : LogicalTime -> LogicalTime
increment (LogicalTime n) =
    LogicalTime (n + 1)


max : LogicalTime -> LogicalTime -> LogicalTime
max (LogicalTime n) (LogicalTime m) =
    LogicalTime (Basics.max n m)
