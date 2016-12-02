module Management.Models exposing (..)

import EventMap.Models exposing (..)
import Profile.Models exposing (..)
import Basket.Models exposing (..)
import Quote.Models exposing (..)
import SpotList.Models exposing (..)


type alias Flags =
    { mapendpoint : String }


type alias Model =
    { eventMap : EventMap
    , selectedSpots : SpotList
    }


initialModel : Flags -> Model
initialModel flags =
    { eventMap = new
    , selectedSpots = []
    }
