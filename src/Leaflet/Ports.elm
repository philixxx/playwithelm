port module Leaflet.Ports exposing (..)

import Leaflet.Types exposing (LatLng, ZoomPanOptions)
import Json.Encode exposing (..)
import Json.Encode exposing (Value)


port setView : ( LatLng, Int, ZoomPanOptions ) -> Cmd msg


port loadData : Json.Encode.Value -> Cmd msg


port spotActionOn : (( String, String ) -> msg) -> Sub msg


port spotPropertiesHasBeenUpdated : Value -> Cmd msg


port updateSpotSelectStateTo : ( String, String ) -> Cmd msg



{-
   JS Incoming
-}


port spotttClicked : String -> Cmd msg


port zoomLevelChanged : (Int -> msg) -> Sub msg


port centerChanged : ({lat: Float, lng: Float} -> msg) -> Sub msg
