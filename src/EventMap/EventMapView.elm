module EventMap.EventMapView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import EventMap.Messages exposing (..)
import EventMap.Models exposing (..)


view : EventMap -> Html Msg
view eventMap =
    div []
        [ nav eventMap
        , map eventMap
        ]


nav : EventMap -> Html Msg
nav spots =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Spots" ] ]


map : EventMap -> Html Msg
map eventmap =
    div []
        [ div [ class "p2" ]
            [ text (toString eventmap.zoomLevel) ]
        , div [ Html.Attributes.id "map" ] []
        ]
