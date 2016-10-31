port module Leaflet.Ports exposing (..)

import Leaflet.Types exposing (LatLng, ZoomPanOptions)
import Json.Encode exposing (..)


port setView : ( LatLng, Int, ZoomPanOptions ) -> Cmd msg


port loadData : Json.Encode.Value -> Cmd msg


port selectPlace : String -> Cmd msg


port block : String -> Cmd msg
