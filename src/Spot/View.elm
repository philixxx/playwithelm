module Spot.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick, onInput)
import Spot.Models exposing (..)
import Spot.Messages exposing (..)


toggleBlock : SpotStatus -> Html Msg
toggleBlock status =
    case status of
        AVAILABLE ->
            button [ onClick (Block), class "toto" ] [ text ("Bloquer") ]

        BLOCKED ->
            button [ onClick (Unblock), class "toto" ] [ text ("Débloquer") ]

        UNKNOWN ->
            button [ onClick (Block), class "toto " ] [ text ("Error") ]


view : Spot -> Html Msg
view spot =
    tr []
        [ td [] [ text (toString spot.properties.id) ]
        , toggleBlock spot.properties.status
        , td [] [ text (statusToString spot.properties.status) ]
        ]

viewedit : Spot -> Html Msg
viewedit spot =
    tr []
        [ td [] [ text (toString spot.properties.id) ]
        , td [] [ text (toString spot.properties.sectorName) ]
        , td [] [ text (toString spot.properties.sectorIndex) ]
        , input [ onInput SectorIndexChange ] []
        ]

statusToString : SpotStatus -> String
statusToString status =
    case status of
        AVAILABLE ->
            "AVAILABLE"

        BLOCKED ->
            "BLOCKED"

        UNKNOWN ->
            "UNKNOWN"
