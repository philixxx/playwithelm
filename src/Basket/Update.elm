module Basket.Update exposing (..)

import Basket.Messages exposing (..)
import Basket.Models exposing (..)
import Set exposing (insert, remove)


update : Msg -> Basket -> ( Basket, Cmd Msg )
update msg model =
    case msg of
        AddSpotToBasket spotId ->
            let
                newSpots =
                    insert spotId model.spots
            in
                ( { model | spots = newSpots }, Cmd.none )

        RemoveSpotFromBasket spotId ->
            let
                newSpots =
                    remove spotId model.spots
            in
                ( { model | spots = newSpots }, Cmd.none )
