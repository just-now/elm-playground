module Test.Generated.Main274642099 exposing (main)

import Example2
import Example

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "Example2" [Example2.suite],     Test.describe "Example" [Example.suite] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 118748940150294, processes = 4, paths = ["/Users/anatoliy/Private/elm/tests/Example.elm","/Users/anatoliy/Private/elm/tests/Example2.elm"]}