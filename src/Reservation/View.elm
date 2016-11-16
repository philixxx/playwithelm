module Reservation.View exposing (..)

import Html exposing (Html, div, text, button)
import Html.App
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (..)
import EventMap.Models exposing (EventMap)
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
            [ button [ onClick <| LoadData ] [ text "Load Data for Reservation" ]
            , div [ Html.Attributes.id "map" ] []
            , Html.App.map BasketMsg (Basket.View.view model.basket)
            ]
        ]
