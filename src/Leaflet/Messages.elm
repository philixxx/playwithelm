module Leaflet.Messages exposing (..)

import Spot.Models exposing (SpotId, Spot)


type Msg
    = SpotSelected SpotId
    | SpotUnselected SpotId
    | SpotAdded Spot
    | SpotRemoved String
