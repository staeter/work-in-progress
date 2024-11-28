module GSet exposing
    ( GSet(..)
    , diff
    , empty
    , except
    , filter
    , fromList
    , insert
    , intersect
    , isEmpty
    , map
    , member
    , remove
    , singleton
    , toList
    , union
    )

import FastDict as Dict exposing (Dict)


type GSet comparable a
    = GSet (Dict comparable a)


empty : GSet comparable a
empty =
    GSet Dict.empty


singleton : (a -> comparable) -> a -> GSet comparable a
singleton toComparable val =
    let
        dict =
            Dict.singleton (toComparable val) val
    in
    GSet dict


map : (b -> comparable) -> (a -> b) -> GSet comparable a -> GSet comparable b
map newToString func set =
    toList set
        |> List.map func
        |> fromList newToString


insert : (a -> comparable) -> a -> GSet comparable a -> GSet comparable a
insert toComparable val (GSet dict) =
    Dict.insert (toComparable val) val dict
        |> GSet


remove : (a -> comparable) -> a -> GSet comparable a -> GSet comparable a
remove toComparable val (GSet dict) =
    Dict.remove (toComparable val) dict
        |> GSet


isEmpty : GSet comparable a -> Bool
isEmpty (GSet dict) =
    Dict.isEmpty dict


member : (a -> comparable) -> a -> GSet comparable a -> Bool
member toComparable val (GSet dict) =
    Dict.member (toComparable val) dict


union : GSet comparable a -> GSet comparable a -> GSet comparable a
union (GSet dictA) (GSet dictB) =
    Dict.union dictA dictB
        |> GSet


intersect : GSet comparable a -> GSet comparable a -> GSet comparable a
intersect (GSet dictA) (GSet dictB) =
    Dict.intersect dictA dictB
        |> GSet


diff : GSet comparable a -> GSet comparable a -> GSet comparable a
diff (GSet dictA) (GSet dictB) =
    Dict.diff dictA dictB
        |> GSet


{-| GSet comparable a except what is in GSet comparable b
-}
except : GSet comparable a -> GSet comparable a -> GSet comparable a
except (GSet dictA) (GSet dictB) =
    Dict.diff dictA dictB
        |> Dict.filter (\k _ -> Dict.member k dictB |> not)
        |> GSet


toList : GSet comparable a -> List a
toList (GSet dict) =
    Dict.toList dict
        |> List.map Tuple.second


fromList : (a -> comparable) -> List a -> GSet comparable a
fromList toComparable list =
    List.map (\val -> ( toComparable val, val )) list
        |> Dict.fromList
        |> GSet


filter : (k -> Bool) -> GSet comparable k -> GSet comparable k
filter func (GSet dict) =
    GSet (Dict.filter (\_ val -> func val) dict)
