module Management.View exposing (..)

import Html exposing (Html, div, text, button)
import Html.App
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Management.Models exposing (..)
import EventMap.EventMapView
import EventMap.Models exposing (EventMap)
import EventMap.EventMapView exposing (..)
import SpotList.View
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
            [ viewMap model.eventMap
            , Html.App.map SpotListMsg (SpotList.View.view model.selectedSpots)
            ]
        ]


viewMap : EventMap -> Html Msg
viewMap eventMap =
    header
        [ class "header" ]
        [ div []
            [ Html.App.map EventMsg (EventMap.EventMapView.view eventMap)
            ]
        ]
