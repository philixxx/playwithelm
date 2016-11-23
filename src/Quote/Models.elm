module Quote.Models exposing (..)

import Basket.Models exposing (Basket)


type alias Quote =
    { url : String
    }


type alias Quotation =
    { quotation : Int
    }


type alias QuoteRequest =
    { basket : Basket
    , profile : String
    }
