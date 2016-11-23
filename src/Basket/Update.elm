module Basket.Update exposing (..)

import Basket.Messages exposing (..)
import Basket.Models exposing (..)
import Set exposing (insert, remove)
import Leaflet.Ports exposing (updateSpotSelectStateTo)


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
                ( newModel, Leaflet.Ports.updateSpotSelectStateTo ( spotId, "SELECTED" ) )

        RemoveSpotFromBasket spotId ->
            let
                newSpots =
                    remove spotId model.spots
            in
                ( { model | spots = newSpots }, Leaflet.Ports.updateSpotSelectStateTo ( spotId, "UNSELECTED" ) )
