module Messages exposing (..)

import EventMap.Messages
import Spots.Messages exposing (SpotListMessage(..))
import Leaflet.Types exposing (LatLng)


type Msg
    = EventMsg EventMap.Messages.Msg
    | SpotMsgParent Spots.Messages.SpotListMessage
    | SetLatLng LatLng
    | LoadData
