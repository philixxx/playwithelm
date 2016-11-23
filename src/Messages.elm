module Messages exposing (..)

import EventMap.Messages
import Profile.Messages
import SpotList.Messages
import Leaflet.Messages
import Basket.Messages
import Quote.Messages
import Leaflet.Types exposing (LatLng)


type Msg
    = EventMsg EventMap.Messages.Msg
    | ProfileMsg Profile.Messages.Msg
    | ProfileUpdateMsg Profile.Messages.ProfileUpdatedMsg
    | SpotListMsg SpotList.Messages.Msg
    | SetLatLng LatLng
    | SpotttClickedMsg Leaflet.Messages.Msg
    | BasketMsg Basket.Messages.Msg
    | QuoteMsg Quote.Messages.Msg
    | Pay
