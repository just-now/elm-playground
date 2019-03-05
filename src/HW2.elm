module HW2 exposing (..)
import List exposing (map, filter, filterMap)
import Maybe exposing (withDefault)
import Url.Builder exposing(absolute,string,int)

-- Map one structure to another
convert
  : List { name : String, email : String, phone_number : String}
  -> List { name : String, email : String}
convert = map (\x -> { name = x.name, email = x.email })

-- Filter elements with non-empty name and email
convert02
  : List { name : Maybe String, email : Maybe String}
  -> List { name : String, email : String}
convert02 = filter (\x -> not(x.name == Nothing || x.email == Nothing)) >>
            map (\ne -> { name = withDefault "" ne.name,
                          email = withDefault "" ne.email })

-- Fill in missing emails with <unspecified>, while removing elements
-- with no name
convert03
  : List { name : Maybe String, email : Maybe String}
  -> List { name : String, email : String}
convert03 = filter (\x -> x.name /= Nothing) >>
            map (\ne -> { name = withDefault "" ne.name,
                          email = withDefault "<unspecified>" ne.email })

-- Rewrite bird using <|, then using |> instead of parens (where applicable)

bird : Int
bird =
    let
        notThree x =
            x /= 3

        incr x =
            x + 1
    in
    List.sum (List.filter notThree (List.map incr [ 1, 2, 3 ]))

-- using <|
bird2 : Int
bird2 =
    let
        notThree x =
            x /= 3

        incr x =
            x + 1
    in
    List.sum <| List.filter notThree <| List.map incr <| [ 1, 2, 3 ]


-- using |>
bird3 : Int
bird3 =
    let
        notThree x =
            x /= 3

        incr x =
            x + 1
    in
        [ 1, 2, 3 ] |> List.map incr |> List.filter notThree |> List.sum

-- mapMaybes
mapMaybes : (a -> Maybe b) -> List a -> List b
mapMaybes f l = map f l |> filterMap identity

-- catMaybes
catMaybes : List (Maybe a) -> List a
catMaybes = filterMap identity

-- Use package elm/url and its Url.Builder.absolute to build URL from parameters
buildStatsUrl : Int -> { startDate : Maybe String, numElems : Maybe Int } -> String
buildStatsUrl itemId ps =
  Debug.todo ""

-- > buildStatsUrl 12 {startDate=Nothing, numElems=Nothing}
-- https://myapi.com/api/item/12/stats.json
-- > buildStatsUrl 12 {startDate=Just "2019-01-01", numElems=Nothing}
-- https://myapi.com/api/item/12/stats.json?start_date=2019-01-01
-- > buildStatsUrl 12 {startDate=Just "2019-01-01", numElems=Just 10}
-- https://myapi.com/api/item/12/stats.json?start_date=2019-01-01&num_items=10
-- See if using catMaybes would help as number of GET-parameters will grow

-- Temperature converter
-- Implement "Temperature Converter" from 7GYUs as described in https://eugenkiss.github.io/7guis/tasks

-- Implement setPhone

type alias User = { profile : Profile }
type alias Profile = { address : Address }
type alias Address = { phone : String }

setPhone : String -> User -> User
setPhone = Debug.todo ""

-- > setPhone "+123456" { profile = { address = { phone = "+654321" } } }
-- { profile = { address = { phone = "+123456" } } }
