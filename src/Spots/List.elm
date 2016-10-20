module Spots.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Spots.Messages exposing (..)
import Spots.Models exposing (Spot)
import Html.Events exposing (onClick)


view : List Spot -> Html SpotListMessage
view spots =
    div []
        [ nav spots
        , list spots
        ]


nav : List Spot -> Html SpotListMessage
nav spots =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Spots" ] ]


list : List Spot -> Html SpotListMessage
list spots =
    div [ class "p2" ]
        [ text (toString (List.length spots))
        , table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map spotRow spots)
            ]
        ]


spotRow : Spot -> Html SpotListMessage
spotRow spot =
    tr []
        [ td [] [ text (toString spot.properties.id) ]
        , button [ onClick (SPLMessage (Block spot)), class "toto" ] [ text ("Bloquer") ]
        , td [] [ text (toString spot.properties.status) ]
        ]
