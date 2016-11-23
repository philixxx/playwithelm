module Quote.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Json.Encode
import Payment.Commands exposing (reservationEncoder)
import Quote.Models exposing (Quotation)
import Quote.Messages exposing (Msg(..))
import Basket.Models exposing (Basket)


fetchQuote : String -> Basket -> String -> Cmd Msg
fetchQuote endpoint basket profile =
    Http.post quoteDecoder endpoint (Http.string (reservationEncoder basket profile |> Json.Encode.encode 0))
        |> Task.perform FetchQuoteFail FetchQuoteDone


quoteDecoder : Decode.Decoder Quotation
quoteDecoder =
    Decode.object1
        Quotation
        ("quotation" := Decode.int)
