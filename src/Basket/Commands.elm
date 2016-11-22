module Basket.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Basket.Messages exposing (Msg(..))
import Basket.Models exposing (..)


fetchQuote : Basket -> Cmd Msg
fetchQuote quoteRequest =
    Http.post quoteDecoder quoteRequest.endpoint (quoteRequestToBody quoteRequest)
        |> Task.perform FetchQuoteFail FetchQuoteDone


quoteRequestToBody : Basket -> Http.Body
quoteRequestToBody quoteRequest =
    Http.string """{"profile": "PARTICULIER", "exhibitorStatus": "RESIDENT", "spots": ["graphid123", "graphid456", "graphid789"]}"""


quoteDecoder : Decode.Decoder Quotation
quoteDecoder =
    Decode.object1
        Quotation
        ("quotation" := Decode.int)
