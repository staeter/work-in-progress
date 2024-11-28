module GDict exposing
    ( GDict(..)
    , diff
    , empty
    , except
    , filter
    , filterMap
    , fromList
    , get
    , getFromStringKey
    , getKeyIf
    , getKeys
    , getSet
    , insert
    , intersect
    , isEmpty
    , keys
    , map
    , mapKey
    , mapValue
    , member
    , related
    , remove
    , removeSet
    , singleton
    , toList
    , union
    , update
    , values
    )

import FastDict as Dict exposing (Dict)
import GSet exposing (GSet)


type GDict comparable k a
    = GDict (Dict comparable ( k, a ))


empty : GDict comparable k a
empty =
    GDict Dict.empty


singleton : (k -> comparable) -> k -> a -> GDict comparable k a
singleton keyToComparable key val =
    let
        dict =
            Dict.singleton (keyToComparable key) ( key, val )
    in
    GDict dict


insert : (k -> comparable) -> k -> a -> GDict comparable k a -> GDict comparable k a
insert keyToComparable key val (GDict dict) =
    Dict.insert (keyToComparable key) ( key, val ) dict
        |> GDict


update : (k -> comparable) -> k -> (Maybe a -> Maybe a) -> GDict comparable k a -> GDict comparable k a
update keyToComparable key func (GDict dict) =
    let
        funcAppliedToVal =
            Maybe.map Tuple.second
                >> func
                >> Maybe.map (\val -> ( key, val ))
    in
    Dict.update (keyToComparable key) funcAppliedToVal dict
        |> GDict


map : (k -> a -> b) -> GDict comparable k a -> GDict comparable k b
map func (GDict dict) =
    let
        funcAppliedToVal _ ( key, val ) =
            ( key, func key val )
    in
    Dict.map funcAppliedToVal dict
        |> GDict


mapKey : (b -> comparable) -> (a -> b) -> GDict comparable a v -> GDict comparable b v
mapKey newToString func dict =
    toList dict
        |> List.map (Tuple.mapFirst func)
        |> fromList newToString


mapValue : (a -> b) -> GDict comparable k a -> GDict comparable k b
mapValue func (GDict dict) =
    let
        funcAppliedToVal _ ( key, val ) =
            ( key, func val )
    in
    Dict.map funcAppliedToVal dict
        |> GDict


remove : (k -> comparable) -> k -> GDict comparable k a -> GDict comparable k a
remove keyToComparable key (GDict dict) =
    Dict.remove (keyToComparable key) dict
        |> GDict


removeSet : (k -> comparable) -> GSet comparable k -> GDict comparable k v -> GDict comparable k v
removeSet keyToComparable set dict =
    filter keyToComparable (\k _ -> GSet.member keyToComparable k set |> not) dict


filter : (k -> comparable) -> (k -> v -> Bool) -> GDict comparable k v -> GDict comparable k v
filter keyToComparable func dict =
    toList dict
        |> List.filter (\( k, v ) -> func k v)
        |> fromList keyToComparable


filterMap : (k -> comparable) -> (k -> v1 -> Maybe v2) -> GDict comparable k v1 -> GDict comparable k v2
filterMap keyToComparable func dict =
    toList dict
        |> List.filterMap (\( k, v ) -> Maybe.map (Tuple.pair k) (func k v))
        |> fromList keyToComparable


isEmpty : GDict comparable k a -> Bool
isEmpty (GDict dict) =
    Dict.isEmpty dict


member : (k -> comparable) -> k -> GDict comparable k a -> Bool
member keyToComparable key (GDict dict) =
    Dict.member (keyToComparable key) dict


get : (k -> comparable) -> k -> GDict comparable k a -> Maybe a
get keyToComparable key (GDict dict) =
    Dict.get (keyToComparable key) dict
        |> Maybe.map Tuple.second


{-| return the key-val pair for the given string if it corresponds to the result of one of the keyToComparable key
-}
getFromStringKey : comparable -> GDict comparable k a -> Maybe ( k, a )
getFromStringKey comparableKey (GDict dict) =
    Dict.get comparableKey dict


getSet : (k -> comparable) -> GSet comparable k -> GDict comparable k a -> GDict comparable k a
getSet keyToComparable set dict =
    toList dict
        |> List.filterMap
            (\( k, v ) ->
                if GSet.member keyToComparable k set then
                    Just ( k, v )

                else
                    Nothing
            )
        |> fromList keyToComparable


getKeys : (k -> comparable) -> GDict comparable k v -> GSet comparable k
getKeys keyToComparable dict =
    toList dict
        |> List.map Tuple.first
        |> GSet.fromList keyToComparable


getKeyIf : (k -> comparable) -> (k -> v -> Bool) -> GDict comparable k v -> GSet comparable k
getKeyIf keyToComparable func dict =
    toList dict
        |> List.filterMap
            (\( k, v ) ->
                if func k v then
                    Just k

                else
                    Nothing
            )
        |> GSet.fromList keyToComparable


{-| gives a set of keys related through common v
-}
related : (k -> comparable) -> (v -> comparable) -> k -> GDict comparable k (GSet comparable v) -> ( GSet comparable k, GSet comparable v )
related keyToComparable valToString key dict =
    case get keyToComparable key dict of
        Just valSet ->
            related_Rec keyToComparable dict ( GSet.singleton keyToComparable key, valSet )

        _ ->
            ( GSet.empty, GSet.empty )


related_Rec : (k -> comparable) -> GDict comparable k (GSet comparable v) -> ( GSet comparable k, GSet comparable v ) -> ( GSet comparable k, GSet comparable v )
related_Rec keyToComparable dict ( keySet, valSet ) =
    let
        isRelated =
            Tuple.second
                >> GSet.intersect valSet
                >> GSet.isEmpty
                >> not

        relatedList =
            toList dict |> List.filter isRelated

        ( addedKeys, newValSet ) =
            List.foldr
                accumulate
                ( GSet.empty, valSet )
                relatedList

        accumulate ( key_, valSet_ ) ( accKeySet, accValSet ) =
            ( GSet.insert keyToComparable key_ accKeySet
            , GSet.union valSet_ accValSet
            )

        newKeySet =
            GSet.union addedKeys keySet
    in
    if List.isEmpty relatedList then
        ( keySet, valSet )

    else
        related_Rec
            keyToComparable
            (removeSet keyToComparable addedKeys dict)
            ( newKeySet, newValSet )


{-| Combine two dictionaries. If there is a collision, preference is given to the first dictionary.
-}
union : GDict comparable k a -> GDict comparable k a -> GDict comparable k a
union (GDict dictA) (GDict dictB) =
    Dict.union dictA dictB
        |> GDict


intersect : GDict comparable k a -> GDict comparable k a -> GDict comparable k a
intersect (GDict dictA) (GDict dictB) =
    Dict.intersect dictA dictB
        |> GDict


diff : GDict comparable k a -> GDict comparable k b -> GDict comparable k a
diff (GDict dictA) (GDict dictB) =
    Dict.diff dictA dictB
        |> GDict


{-| GDict a except what is in GDict b
-}
except : GDict comparable k a -> GDict comparable k a -> GDict comparable k a
except (GDict dictA) (GDict dictB) =
    Dict.diff dictA dictB
        |> Dict.filter (\k _ -> Dict.member k dictB |> not)
        |> GDict


toList : GDict comparable k a -> List ( k, a )
toList (GDict dict) =
    Dict.values dict


keys : GDict comparable k a -> List k
keys dict =
    toList dict |> List.map Tuple.first


values : GDict comparable k a -> List a
values dict =
    toList dict |> List.map Tuple.second


fromList : (k -> comparable) -> List ( k, a ) -> GDict comparable k a
fromList keyToComparable list =
    List.map (\( key, val ) -> ( keyToComparable key, ( key, val ) )) list
        |> Dict.fromList
        |> GDict
