module Models exposing (..)

import EventMap.Models exposing (..)
import Leaflet.Types exposing (LatLng, ZoomPanOptions, defaultZoomPanOptions)


type alias Model =
    { eventMap : EventMap
    , latLng : LatLng
    , zoomPanOptions : ZoomPanOptions
    }


initialModel : Model
initialModel =
    { eventMap = new
    , latLng = chevreul
    , zoomPanOptions = defaultZoomPanOptions
    }


chevreul : LatLng
chevreul =
    ( 45.7463, 4.8324 )


boulderLatLng : LatLng
boulderLatLng =
    ( 40.015, -105.2705 )
