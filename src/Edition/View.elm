module Edition.View exposing (..)

import Html exposing (Html, div, text, button)
import Html.App
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Edition.Models exposing (..)
import EventMap.EventMapView
import EventMap.Models exposing (EventMap)
import EventMap.EventMapView exposing (..)
import Sector.View
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
            , viewDrawSelectors
            , Html.App.map SectorMsg (Sector.View.view model.sector.spots)
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
            ]
        ]


countOption count =
  option [value (toString count) ] [ text (toString count)]

widthOption width =
  option [value (toString width) ] [ text (toString width)]

viewDrawSelectors : Html Msg
viewDrawSelectors =
    span []
        [ h4 [] [ text "Options de dessin"]
        , span [] [ text "Diviser en N emplacements"]
        , select [ id "nb-emplacements-form" ] ( List.map countOption [1..100] )
        , span [] [ text " Profondeur des emplacements (mètres)"]
        , select [ id "width-form" ] ( List.map widthOption [1..10] )
        ]
