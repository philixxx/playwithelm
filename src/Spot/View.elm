module Spot.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Spot.Models exposing (..)
import Spot.Messages exposing (..)


view : Spot -> Html Msg
view spot =
    tr []
        [ td [] [ text (toString spot.properties.id) ]
        , button [ onClick (Block), class "toto" ] [ text ("Bloquer") ]
        , td [] [ text (toString spot.properties.status) ]
        ]
