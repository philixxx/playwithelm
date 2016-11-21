module Basket.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Json.Encode
import Basket.Messages exposing (Msg(..))
import Basket.Models exposing (..)
import Payment.Commands exposing (reservationEncoder)


fetchQuote : Basket -> Cmd Msg
fetchQuote basket =
    Http.post quoteDecoder basket.endpoint (Http.string (reservationEncoder basket |> Json.Encode.encode 0))
        |> Task.perform FetchQuoteFail FetchQuoteDone


quoteDecoder : Decode.Decoder Quotation
quoteDecoder =
    Decode.object1
        Quotation
        ("quotation" := Decode.int)
