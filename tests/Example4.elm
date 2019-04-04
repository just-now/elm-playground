module Example4 exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import HW4 exposing(..)
import HW5 exposing(..)
import Date exposing(..)
import Json.Decode as J

suite : Test
suite =
    describe "Home Work #4"
    [ test "decode1"
          (\_ -> Expect.equal ( Ok { cats = Just 2, name = "Kostia" } ) <|
               J.decodeString decodeUser "{\"name\": \"Kostia\", \"cats\": 2}")
    , test "decode2"
          (\_ -> Expect.equal ( Ok { cats = Nothing, name = "Droopy .." } ) <|
               J.decodeString decodeUser "{\"name\": \"Droopy ..\", \"cats\": null}")
    , test "decode3"
          (\_ -> Expect.equal ( Ok { currency = "EUR", motto = "Einigkeit und .." } ) <|
               J.decodeString decodeCountryData """{"motto": "Einigkeit und ..", "currency": "EUR"}""")
    , test "decode5"
        (\_ -> Expect.equal (Ok { email = "bb@u.net",
                                  full_name = Just "A",
                                  id = 1,
                                  info_complete = True,
                                  phone_number = Just "555" }) <|
             J.decodeString HW4.jsonDecAccountInfo HW4.accInfo)
    -- , test "decode4"
    --     (\_ -> Expect.equal Ok (RD 736968) <|
    --          J.decodeString HW4.decodeDate "\"2018-10-01\"")
    , test "my-decode-1"
        (\_ -> Expect.equal (Ok 4) <|
             decodeValue (myJsonInt) (Num 4))
    , test "my-decode-2"
        (\_ -> Expect.equal (Ok 4) <|
             decodeValue (myJsonField "foo" myJsonInt) (Obj [("foo", Num 4)]))

    ]
