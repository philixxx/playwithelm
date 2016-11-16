module Messages exposing (..)

import EventMap.Messages
import SpotList.Messages
import Leaflet.Messages
import Basket.Messages
import Leaflet.Types exposing (LatLng)


type Msg
    = EventMsg EventMap.Messages.Msg
    | SpotListMsg SpotList.Messages.Msg
    | SetLatLng LatLng
    | LoadData
    | SpotttClickedMsg Leaflet.Messages.Msg
    | BasketMsg Basket.Messages.Msg
