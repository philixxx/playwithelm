module Basket.Models exposing (..)

import Spot.Models exposing (Spot)


type alias Basket =
    { spots : List Spot
    }
