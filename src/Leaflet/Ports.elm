port module Leaflet.Ports exposing (..)

import Leaflet.Types exposing (LatLng, ZoomPanOptions)
import Json.Encode exposing (..)
import Json.Encode exposing (Value)


port setView : ( LatLng, Int, ZoomPanOptions ) -> Cmd msg


port loadData : Json.Encode.Value -> Cmd msg


port spotActionOn : (( String, String ) -> msg) -> Sub msg


port spotPropertiesHasBeenUpdated : Value -> Cmd msg



{-
   JS Incoming
-}


port spotttClicked : String -> Cmd msg
