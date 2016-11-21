module Basket.Messages exposing (..)

import Basket.Models exposing (..)
import Http


type Msg
    = AddSpotToBasket String
    | RemoveSpotFromBasket String
    | FetchQuoteFail Http.Error
    | FetchQuoteDone Quotation
