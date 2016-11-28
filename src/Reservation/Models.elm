module Reservation.Models exposing (..)

import EventMap.Models exposing (..)
import Profile.Models exposing (..)
import Basket.Models exposing (..)
import Quote.Models exposing (..)


type alias Flags =
    { mapendpoint : String
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
    , basket = { spots = [] }
    , profile = { profiles = [] }
    , currentProfile = "None"
    , quote = { url = flags.quoteendpoint }
    , quotation = { quotation = 1 }
    }
