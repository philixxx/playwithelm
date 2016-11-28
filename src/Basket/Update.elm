module Basket.Update exposing (..)

import Basket.Messages exposing (..)
import Basket.Models exposing (..)
import Leaflet.Ports exposing (updateSpotSelectStateTo)


update : Msg -> Basket -> ( Basket, Cmd Msg )
update msg model =
    case msg of
        AddSpotToBasket spot ->
            let
                newSpots =
                    spot :: model.spots

                newModel =
                    { model | spots = newSpots }
            in
                ( newModel, Leaflet.Ports.updateSpotSelectStateTo ( spot.properties.id, "SELECTED" ) )

        RemoveSpotFromBasket spot ->
            let
                newSpots =
                    List.filter (\sp -> sp.properties.id /= spot.properties.id) model.spots

                newModel =
                    { model | spots = newSpots }
            in
                Debug.log ("BLA")
                    ( newModel, Leaflet.Ports.updateSpotSelectStateTo ( spot.properties.id, "UNSELECTED" ) )
