module Example3 exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import HW3 exposing(..)
import Date exposing(..)

suite : Test
suite =
    describe "Home Work #3"
    [ test "maybeToList1" (\_ -> Expect.equal [3] <| maybeToList (Just 3))
    , test "maybeToList2" (\_ -> Expect.equal []  <| maybeToList Nothing)
    , test "updateList1"  (\_ -> Expect.equal [1,4,5]
                               <| updateList (\x -> x == 3) (\v -> Just (v + 1)) [1,3,5])
    , test "updateList2"  (\_ -> Expect.equal [1,5]
                               <| updateList (\x -> x == 3) (\v -> Nothing) [1,3,5])
    , test "find1" (\_ -> Expect.equal (Just 2) <| find (\x -> x == 2) [1,3,5,2])
    , test "find2" (\_ -> Expect.equal Nothing  <| find (\x -> x == 2) [1,3,5])
    , test "updateListKv1" (\_ -> Expect.equal [("foo", 2), ("bar", 2)]
                   <| updateListKv [("foo", 1), ("bar", 2)] "foo" (\x -> Just (x + 1)))
    , test "updateListKv2" (\_ -> Expect.equal [("bar", 2)]
                   <| updateListKv [("foo", 1), ("bar", 2)] "foo" (\x -> Nothing))
    , test "keepOks1" (\_ -> Expect.equal [1,2] <| keepOks [Ok 1, Err "bad", Ok 2])
    , test "mapOk1"   (\_ -> Expect.equal (Ok 3) <| mapOk (\x -> x + 1) (Ok 2))
    , test "mapOk2"   (\_ -> Expect.equal (Err "str") <| mapOk (\x -> x + 1) (Err "str"))
    , test "either1"  (\_ -> Expect.equal 0 <| either (\x -> x + 1) (\x -> x - 1) (Ok 1))
    , test "either2"  (\_ -> Expect.equal 2 <| either (\x -> x + 1) (\x -> x - 1) (Err 1))
    -- , test "parseDat" (\_ -> Expect.equal Just (RD 735234) <| parseDate (Just "2014-01-01"))
    ]
