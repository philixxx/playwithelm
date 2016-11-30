module Basket.Messages exposing (..)

import Spot.Models exposing (..)


type Msg
    = AddSpotToBasket Spot
    | RemoveSpotFromBasket Spot
