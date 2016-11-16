module Models exposing (..)

import EventMap.Models exposing (..)
import Basket.Models exposing (..)
import Set exposing (empty)


type alias Model =
    { eventMap : EventMap
    , basket : Basket
    }


initialModel : Model
initialModel =
    { eventMap = new
    , basket = { spots = empty }
    }
