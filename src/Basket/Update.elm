module Basket.Update exposing (..)

import Basket.Messages exposing (..)
import Basket.Models exposing (..)
import Basket.Commands exposing (..)
import Set exposing (insert, remove)


update : Msg -> Basket -> ( Basket, Cmd Msg )
update msg model =
    case msg of
        AddSpotToBasket spotId ->
            let
                newSpots =
                    insert spotId model.spots

                newModel =
                    { model | spots = newSpots }
            in
                ( newModel, fetchQuote model )

        RemoveSpotFromBasket spotId ->
            let
                newSpots =
                    remove spotId model.spots
            in
                ( { model | spots = newSpots }, fetchQuote model )

        FetchQuoteFail err ->
            let
                quoteErr =
                    quoteError
            in
                Debug.log ("FetchQuoteFail : " ++ toString err)
                    ( { model | quotation = quoteErr }, Cmd.none )

        FetchQuoteDone quote ->
            Debug.log ("FetchQuoteDone")
                ( { model | quotation = quote }, Cmd.none )


quoteError : Quotation
quoteError =
    { quotation = -1 }
