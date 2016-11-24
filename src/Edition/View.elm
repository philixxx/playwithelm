module Edition.View exposing (..)

import Html exposing (Html, div, text, button)
import Html.App
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Edition.Models exposing (..)
import EventMap.EventMapView
import EventMap.Models exposing (EventMap)
import EventMap.EventMapView exposing (..)
import SpotList.View
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg(..), EditMessage(..))


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    div
        [ class "todomv-wrapper" ]
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
            [ button [ onClick <| EditMsg (SaveZoomLevel) ] [ text "Sauvegarder ce niveau de zoom" ]
            , button [ onClick <| EditMsg (SaveCenter) ] [ text "Sauvegarder ce centre de carte" ]
            , Html.App.map
                EventMsg
                (EventMap.EventMapView.view eventMap)
            , Html.App.map SpotListMsg (SpotList.View.view eventMap.draw.features)
            ]
        ]
