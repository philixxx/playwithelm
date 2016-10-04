port module Main exposing (..)

import Tests
import SpotParserTests
import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)

main : Program Value
main =
   run emit  SpotParserTests.all



port emit : ( String , Value ) -> Cmd msg

