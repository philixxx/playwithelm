module Reservation.View exposing (..)

import Html exposing (Html, div, text, button)
import Html.App
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (..)
import Models exposing (Model)
import Basket.View
import Html exposing (..)
import Html.Attributes exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    div
        [ class "todomvc-wrapper" ]
        [ section
            [ class "klapp" ]
            [ viewMap model
            ]
        ]


viewMap : Model -> Html Msg
viewMap model =
    header
        [ class "header" ]
        [ div []
            [ button [ onClick <| LoadData, class "btn ink-reaction btn-raised btn-primary" ] [ text "Load Data for Reservation" ]
            , Html.App.map BasketMsg (Basket.View.view model.basket)
            , button [ Html.Attributes.id "prereserve-button", class "btn ink-reaction btn-raised btn-primary", onClick <| Pay ] [ text "Valider" ]
            ]
        ]
