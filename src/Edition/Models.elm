module Edition.Models exposing (..)

import EventMap.Models exposing (..)


type alias Flags =
    { mapendpoint : String
    }


type alias Model =
    { eventMap : EventMap
    , savezoomlevelendpoint : String
    , savecenterendpoint : String
    , addSpotendpoint : String
    }


initialModel : Flags -> Model
initialModel flags =
    { eventMap = new
    , savezoomlevelendpoint = flags.mapendpoint ++ "/savezoomlevel"
    , savecenterendpoint = flags.mapendpoint ++ "/savecenter"
    , addSpotendpoint = flags.mapendpoint ++ "/addSpot"
    }
