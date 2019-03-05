module Example2 exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import HW2 exposing(..)


suite : Test
suite =
    describe "Home Work #2"
    [ test "convert"
          (\_ -> Expect.equal [{name="John", email="john@gmail.com"}]
               <| convert [{
                       name="John",
                       email="john@gmail.com",
                       phone_number="+3801234567" }])

    , test "convert02"
          (\_ -> Expect.equal [{ email = "john@gmail.com",
                                 name  = "John" }]
               <| convert02 [{name=Just "John", email=Just "john@gmail.com"}
                            ,{name=Nothing,     email=Just "xxx@" }
                            ,{name=Just "x",    email=Nothing} ])
    , test "convert03"
          (\_ -> Expect.equal [{ email = "john@gmail.com", name  = "John" }
                              ,{ email = "<unspecified>",  name = "x" }]
               <| convert03 [{name=Just "John", email=Just "john@gmail.com"},
                             {name=Nothing,     email=Just "xxx@" },
                             {name=Just "x",    email=Nothing} ])
    , test "bird2" <|
        \_ -> Expect.equal bird bird2
    , test "bird3" <|
        \_ -> Expect.equal bird bird3

    ]


