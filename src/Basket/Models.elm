module Basket.Models exposing (..)

import Set exposing (Set)


type alias Basket =
    { spots : Set String
    }
