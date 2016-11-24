module Edition.Models exposing (..)

import EventMap.Models exposing (..)


type alias Flags =
    { getmapendpoint : String
    , savemapendpoint : String
    }


type alias Model =
    { eventMap : EventMap
    }


initialModel : Flags -> Model
initialModel flags =
    { eventMap = new
    }
