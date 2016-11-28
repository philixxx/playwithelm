module Basket.Messages exposing (..)

import Spot.Models exposing (Spot)


type Msg
    = AddSpotToBasket Spot
    | RemoveSpotFromBasket Spot
