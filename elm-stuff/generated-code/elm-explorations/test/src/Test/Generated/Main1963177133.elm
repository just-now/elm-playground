module Test.Generated.Main1963177133 exposing (main)

import Example2
import Example3
import Example

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "Example2" [Example2.suite],     Test.describe "Example3" [Example3.suite],     Test.describe "Example" [Example.suite] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 221525888024066, processes = 4, paths = ["/Users/anatoliy/Private/elm/tests/Example.elm","/Users/anatoliy/Private/elm/tests/Example2.elm","/Users/anatoliy/Private/elm/tests/Example3.elm"]}