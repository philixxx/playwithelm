module View exposing (..)

import Html exposing (Html, div, text, button)
import Html.App
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (..)
import EventMap.EventMapView
import EventMap.Models exposing (EventMap)
import EventMap.EventMapView exposing (..)
import Spots.List exposing (..)
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
            ]
        ]


viewMap : EventMap -> Html Msg
viewMap eventMap =
    header
        [ class "header" ]
        [ div []
            [ button [ onClick <| SetLatLng chevreul ] [ text "Chevreul" ]
            , button [ onClick <| SetLatLng boulderLatLng ] [ text "Set Map Location to Boulder" ]
            , button [ onClick <| LoadData ] [ text "Load Data" ]
            , Html.App.map EventMsg (EventMap.EventMapView.view eventMap)
            , Html.App.map SpotsMsg (Spots.List.view eventMap.draw.features)
            ]
        ]
