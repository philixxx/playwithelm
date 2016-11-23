module Quote.Messages exposing (..)

import Quote.Models exposing (..)
import Http


type Msg
    = FetchQuoteFail Http.Error
    | FetchQuoteDone Quotation
