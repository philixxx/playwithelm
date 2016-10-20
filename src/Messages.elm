module Messages exposing (..)

import EventMap.Messages
import Spots.Messages exposing (SpotListMessages(..))
import Leaflet.Types exposing (LatLng)


type Msg
    = EventMsg EventMap.Messages.Msg
    | SpotMsg Spots.Messages.SpotListMessages
    | SetLatLng LatLng
    | LoadData
