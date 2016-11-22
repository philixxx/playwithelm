module Models exposing (..)

import EventMap.Models exposing (..)
import Basket.Models exposing (..)
import Set exposing (empty)


type alias Flags =
    { getmapendpoint : String
    , savemapendpoint : String
    , quoteenpoint : String
    }


type alias Model =
    { eventMap : EventMap
    , basket : Basket
    }


initialModel : Flags -> Model
initialModel flags =
    { eventMap = new
    , basket = { spots = empty, quotation = emptyQuotation, endpoint = flags.quoteenpoint }
    }


emptyQuotation : Quotation
emptyQuotation =
    { quotation = 0
    }
