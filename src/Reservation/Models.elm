module Reservation.Models exposing (..)

import EventMap.Models exposing (..)
import Profile.Models exposing (..)
import Basket.Models exposing (..)
import Quote.Models exposing (..)
import Set exposing (empty)


type alias Flags =
    { getmapendpoint : String
    , savemapendpoint : String
    , quoteendpoint : String
    , profileendpoint : String
    }


type alias Model =
    { eventMap : EventMap
    , basket : Basket
    , profile : Profile
    , currentProfile : String
    , quote : Quote
    , quotation : Quotation
    }


initialModel : Flags -> Model
initialModel flags =
    { eventMap = new
    , basket = { spots = empty }
    , profile = { profiles = [] }
    , currentProfile = "None"
    , quote = { url = flags.quoteendpoint }
    , quotation = { quotation = 1 }
    }
