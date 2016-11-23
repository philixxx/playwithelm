module Quote.Update exposing (..)

import Quote.Messages exposing (..)
import Quote.Models exposing (..)


update : Msg -> Quotation -> ( Quotation, Cmd Msg )
update msg model =
    case msg of
        FetchQuoteFail err ->
            let
                quoteErr =
                    quoteError
            in
                Debug.log ("FetchQuoteFail : " ++ toString err)
                    ( quoteErr, Cmd.none )

        FetchQuoteDone quote ->
            Debug.log ("FetchQuoteDone")
                ( quote, Cmd.none )


quoteError : Quotation
quoteError =
    { quotation = -1 }
