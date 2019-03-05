module HW1 exposing (..)

{-
range : Int -> Int -> List Int
range start end =
    if start >= end then [] else start::(range (start+1) end)

zip : List a -> List b -> List (a,b)
zip left right =
    case (left, right) of
        ([], _) -> []
        (_, []) -> []
        (l::ls, r::rs) -> (l,r)::(zip ls rs)

empty : List a -> Bool
empty li = li == []
-}

myLast : List a -> Maybe a
myLast l =
    case l of
        [] -> Nothing
        x::[] -> Just x
        x::xs -> myLast xs

myButLast : List a -> Maybe a
myButLast l =
    case l of
        [] -> Nothing
        _::[] -> Nothing
        x::_::[] -> Just x
        _::xs -> myButLast xs

myLength : List a -> Int
myLength list =
    case list of
        [] -> 0
        _::xs -> 1 + myLength(xs)

elementAt : List a -> Int -> Maybe a
elementAt list at =
    case list of
        [] -> Nothing
        x::xs -> if at == 0 then Just x else elementAt xs (at - 1)

myReverse : List a -> List a
myReverse list =
    let rev li ret =
            case li of
                [] -> ret
                x::xs -> rev xs (x::ret)
    in
        rev list []

isPalindrome : List a -> Bool
isPalindrome li =
    let lieq left right = left == right
            -- case (left, right) of
            --     ([], _) -> True
            --     (_, []) -> True
            --     (l::ls, r::rs) -> (l == r) && (lieq ls rs)
    in
        lieq li (myReverse li)

compress : String -> String
compress s =
    let
        comp prev first list =
            case list of
                [] -> []
                x::xs -> case first || prev /= x of
                             True ->  x::(comp x False xs)
                             False -> comp x False xs
    in
        String.fromList <| comp '?' True <| String.toList s

dropEvery : String -> Int -> String
dropEvery s i =
    let drop idx list =
            case list of
                [] -> []
                x::xs -> if idx == 0 then
                             drop (i-1) xs
                         else
                             x::(drop (idx-1) xs)
    in
        String.fromList <| drop (i-1) <| String.toList s
