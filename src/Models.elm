module Models exposing (..)

import EventMap.Models exposing (..)
import Basket.Models exposing (..)
import Set exposing (empty)


type alias Flags =
    { getmapendpoint : String
    , savemapendpoint : String
    , quoteendpoint : String
    }


type alias Model =
    { eventMap : EventMap
    , basket : Basket
    }


initialModel : Flags -> Model
initialModel flags =
    { eventMap = new
    , basket = { spots = empty, quotation = emptyQuotation, endpoint = flags.quoteendpoint }
    }


emptyQuotation : Quotation
emptyQuotation =
    { quotation = 0
    }
