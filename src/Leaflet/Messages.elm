module Leaflet.Messages exposing (..)

import Spot.Models exposing (SpotId)


type Msg
    = SpotSelected SpotId
    | SpotUnselected SpotId
