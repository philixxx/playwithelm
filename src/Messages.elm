module Messages exposing (..)

import EventMap.Messages
import Spots.Messages
import Leaflet.Types exposing (LatLng)


type Msg
    = EventMsg EventMap.Messages.Msg
    | SpotsMsg Spots.Messages.Msg
    | SetLatLng LatLng
    | LoadData
