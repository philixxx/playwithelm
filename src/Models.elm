module Models exposing (..)

import EventMap.Models exposing (..)


type alias Model =
    { eventMap : EventMap
    }


initialModel : Model
initialModel =
    { eventMap = new
    }
