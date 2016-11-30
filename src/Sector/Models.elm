module Sector.Models exposing (..)

import Spot.Models exposing (Spot)


type alias Sector =
    { spots : List Spot
    , savesectorendpoint : String
    }
