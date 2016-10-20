module Spot.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Spot.Models exposing (..)
import Spot.Messages exposing (..)


toggleBlock : Spot -> Html Msg
toggleBlock spot =
    if spot.properties.status == "BLOCKED" then
        button [ onClick (Unblock), class "toto" ] [ text ("Débloquer") ]
    else if spot.properties.status == "ERROR" then
        button [ onClick (Block), class "toto" ] [ text ("Error") ]
    else
        button [ onClick (Block), class "toto" ] [ text ("Bloquer") ]


view : Spot -> Html Msg
view spot =
    tr []
        [ td [] [ text (toString spot.properties.id) ]
        , toggleBlock spot
        , td [] [ text (toString spot.properties.status) ]
        ]
