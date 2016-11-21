module Basket.Models exposing (..)

import Set exposing (Set)


type alias Basket =
    { spots : Set String
    , quotation : Quotation
    }


type alias Quotation =
    { quotation : Int
    }


type alias QuoteRequest =
    { basket : Basket
    }
