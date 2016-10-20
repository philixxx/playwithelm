module Spots.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Spots.Messages exposing (..)
import Spots.Models exposing (Spot)
import Html.Events exposing (onClick)


view : List Spot -> Html SpotListMessages
view spots =
    div []
        [ nav spots
        , list spots
        ]


nav : List Spot -> Html SpotListMessages
nav spots =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Spots" ] ]


list : List Spot -> Html SpotListMessages
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


spotRow : Spot -> Html SpotListMessages
spotRow spot =
    tr []
        [ td [] [ text (toString spot.properties.id) ]
        , button [ onClick (Select ((toString spot.properties.id))), class "toto" ] [ text ("Selectionner") ]
        , button [ onClick (Block ((toString spot.properties.id))), class "toto" ] [ text ("Bloquer") ]
        , td [] [ text (toString spot.properties.status) ]
        ]
