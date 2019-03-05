module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import HW1 exposing(..)


suite : Test
suite =
    describe "Home Work #1"
    [ test "myLast-normal"
          (\_ -> Expect.equal (Just 4) (myLast [1,2,3,4]))
    , test "myLast-empty"
          (\_ -> Expect.equal Nothing (myLast []))
    , test "myLast-one"
          (\_ -> Expect.equal (Just 1) (myLast [1]))
-- 8<-- 8<-- 8<-- 8<-- 8<-- --
    , test "myButLast"
          (\_ -> Expect.equal (Just 3) (myButLast [1,2,3,4]))
    , test "myButLast-0"
          (\_ -> Expect.equal Nothing (myButLast []))
    , test "myButLast-1"
          (\_ -> Expect.equal Nothing (myButLast [1]))
    , test "myButLast-2"
          (\_ -> Expect.equal (Just 1) (myButLast [1,2]))
    , test "myButLast-n"
          (\_ -> Expect.equal (Just 5) (myButLast [1,2,3,4,5,6]))
-- 8<-- 8<-- 8<-- 8<-- 8<-- --
    , test "myLength"
          (\_ -> Expect.equal 3 (myLength [123,456,789]))
-- 8<-- 8<-- 8<-- 8<-- 8<-- --
    , test "myReverse"
          (\_ -> Expect.equal [4,3,2,1] (myReverse [1,2,3,4]))
-- 8<-- 8<-- 8<-- 8<-- 8<-- --
    , test "isPalindromeT"
          (\_ -> Expect.equal True (isPalindrome [1,2,4,8,16,8,4,2,1]))
    , test "isPalindromeF"
          (\_ -> Expect.equal False (isPalindrome [1,2,4,8,16,8,4,2]))
-- 8<-- 8<-- 8<-- 8<-- 8<-- --
    , test "compress"
          (\_ -> Expect.equal "abcade" <| compress "aaaabccaadeeee")
-- 8<-- 8<-- 8<-- 8<-- 8<-- --
    , test "dropEvery"
          (\_ -> Expect.equal "abdeghk" <| dropEvery "abcdefghik" 3)
-- 8<-- 8<-- 8<-- 8<-- 8<-- --
    , fuzz (list int) "never returns a negative value" <|
        \li -> {- Debug.log "li=" -} li |> myReverse |> myReverse |> Expect.equal li
    ]


