module HW3 exposing (..)
import List exposing (map, filter, filterMap, head)
import Maybe exposing (withDefault)
import Date exposing(..)

maybeToList : Maybe a -> List a
maybeToList x =
    case x of
        Just i -> [i]
        Nothing -> []


updateList : (a -> Bool) -> (a -> Maybe a) -> List a -> List a
updateList shouldChange howToChange xs =
    let
        change : (a -> Maybe a)
        change v =
            case (shouldChange v) of
                True -> howToChange v
                False -> Just v
    in
        filterMap change xs

find : (a -> Bool) -> List a -> Maybe a
find f = List.head << List.filter f


updateListKv :
  List (k, v)
  -> k
  -> (v -> Maybe v)
  -> List (k, v)
updateListKv old k f = updateList
                       (\key -> k == Tuple.first key)
                       (\kv ->
                            let
                                key = Tuple.first kv
                                val = f (Tuple.second kv)
                            in
                                case val of
                                    Nothing -> Nothing
                                    Just v -> Just (key, v))
                       old

keepOks : List (Result a b) -> List b
keepOks xss = filterMap Result.toMaybe xss

mapOk : (b -> c) -> Result a b -> Result a c
mapOk = Result.map

either : (a -> c) -> (b -> c) -> Result a b -> c
either fa fb res =
    case res of
        Ok  o  -> fb o
        Err e  -> fa e

parseDate : Maybe String -> Maybe Date
parseDate v =
    case v of
        Nothing -> Nothing
        Just date -> Result.toMaybe <| Date.fromIsoString date
