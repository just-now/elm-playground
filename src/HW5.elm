module HW5 exposing (..)
import Result exposing (..)
import Dict exposing(..)

type Val
    = Str String
    | Num Int
    | Obj (List ( String, Val ))
    | Nil
    | Lst (List Val)

type MyJsonDecoder a
    = MyJsonDecoder (Val -> Result String a)

decodeValue : MyJsonDecoder a -> Val -> Result String a
decodeValue (MyJsonDecoder f) v = f v

myJsonString : MyJsonDecoder String
myJsonString = MyJsonDecoder (\v -> case v of
                                        Str x -> Ok x
                                        _ -> Err "not a str")

myJsonInt : MyJsonDecoder Int
myJsonInt = MyJsonDecoder (\v -> case v of
                                     Num x -> Ok x
                                     _ -> Err "not an int")

myJsonField : String -> MyJsonDecoder a -> MyJsonDecoder a
myJsonField key (MyJsonDecoder f) =
    MyJsonDecoder (\v -> case v of
                             Obj x -> if List.length x /= 1
                                      then
                                          Err ">1 kv in the list"
                                      else
                                          Dict.fromList x |>
                                          Dict.get key |>
                                          Result.fromMaybe "field not found" |>
                                          Result.andThen f

                             _ -> Err "not a field")

-- quite advanced
keyValPairs : MyJsonDecoder a -> MyJsonDecoder (List ( String, a ))
keyValPairs (MyJsonDecoder innerDec) = Debug.todo ""

-- > decodeValue (myJsonInt) (Num 4)
-- Ok 4
-- > decodeValue (myJsonField "foo" myJsonInt) (Obj [("foo", Num 4)])
-- Ok 4
