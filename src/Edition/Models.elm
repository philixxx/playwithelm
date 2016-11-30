module Edition.Models exposing (..)

import EventMap.Models exposing (..)
import Sector.Models exposing (..)


type alias Flags =
    { mapendpoint : String
    }


type alias Model =
    { eventMap : EventMap
    , sector : Sector
    , savezoomlevelendpoint : String
    , savecenterendpoint : String
    , addSpotendpoint : String
    , removeSpotendpoint : String
    }


initialModel : Flags -> Model
initialModel flags =
    { eventMap = new
    , sector = {spots = [], savesectorendpoint = flags.mapendpoint ++ "/savesector"}
    , savezoomlevelendpoint = flags.mapendpoint ++ "/savezoomlevel"
    , savecenterendpoint = flags.mapendpoint ++ "/savecenter"
    , addSpotendpoint = flags.mapendpoint ++ "/addSpot"
    , removeSpotendpoint = flags.mapendpoint ++ "/removeSpot"
    }
