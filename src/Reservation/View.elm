module Reservation.View exposing (..)

import Html exposing (Html, div, text, button)
import Html.App
import Html.Events exposing (onClick)
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg(..))
import Reservation.Models exposing (..)
import Basket.View
import Profile.View


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    div
        []
        [ section
            [ class "todo" ]
            [ viewMap model
            ]
        ]


viewMap : Model -> Html Msg
viewMap model =
    header
        [ class "header" ]
        [ div []
            [ Html.App.map ProfileUpdateMsg (Profile.View.view model.profile)
            , div [ Html.Attributes.id "quotation" ] [ text (toString ((toFloat model.quotation.quotation / 100))) ]
            , Html.App.map BasketMsg (Basket.View.view model.basket)
            , button [ Html.Attributes.id "prereserve-button", class "btn ink-reaction btn-raised btn-primary", onClick <| Pay ] [ text "Valider" ]
            ]
        ]
