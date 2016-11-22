module Models exposing (..)

import EventMap.Models exposing (..)
import Basket.Models exposing (..)
import Set exposing (empty)


type alias Flags =
    { eventid : String
    , getmapprefix : String
    , savemapprefix : String
    , quoteprefix : String
    }


type alias Model =
    { eventMap : EventMap
    , basket : Basket
    }


initialModel : Flags -> Model
initialModel flags =
    { eventMap = new
    , basket = { spots = empty, quotation = emptyQuotation, endpoint = flags.quoteprefix ++ flags.eventid }
    }


emptyQuotation : Quotation
emptyQuotation =
    { quotation = 0
    }
