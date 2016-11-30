module Messages exposing (..)

import EventMap.Messages
import Profile.Messages
import SpotList.Messages
import Leaflet.Messages
import Basket.Messages
import Quote.Messages
import Sector.Messages
import Spot.Messages
import Leaflet.Types exposing (LatLng)
import Http
import EventMap.Models exposing (Center)
import Spot.Models exposing (Spot)


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
    | EditMsg EditMessage
    | ErrorMsg String
    | SectorMsg Sector.Messages.Msg
    | SpotMsg Spot.Messages.Msg


type EditMessage
    = SaveZoomLevel
    | SaveZoomLevelFail Http.Error
    | SaveZoomLevelDone { result : String }
    | ZoomLevelChanged Int
    | SaveCenter
    | SaveCenterFail Http.Error
    | SaveCenterDone { result : String }
    | CenterChanged Center
    | LeafletSpotMsg Leaflet.Messages.Msg
    | AddSpotFailed Http.Error
    | AddSpotDone { result : String }
