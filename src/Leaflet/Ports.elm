port module Leaflet.Ports exposing (setView, loadData, selectPlace)

import Leaflet.Types exposing (LatLng, ZoomPanOptions)


port setView : ( LatLng, Int, ZoomPanOptions ) -> Cmd msg
port loadData : ()-> Cmd msg
port selectPlace : (String)-> Cmd msg