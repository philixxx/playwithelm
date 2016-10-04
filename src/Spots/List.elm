module Spots.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Spots.Messages exposing (..)
import Spots.Models exposing (Spot)
import Html.Events exposing (onClick)


view : List Spot -> Html Msg
view spots =
    div []
        [ nav spots
        , list spots
        ]


nav : List Spot -> Html Msg
nav spots =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Spots" , button [onClick Spots.Messages.Select][text "test"]] ]


list : List Spot -> Html Msg
list spots =
    div [ class "p2" ]
        [ text (toString (List.length spots))
        ,table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Coordinates" ]
                    ]
                ]
            , tbody [] (List.map spotRow spots)
            ]
        ]


spotRow : Spot -> Html Msg
spotRow spot =
    tr []
        [  button [ onClick (Select) ] [ text (toString spot.properties.id)]
          ,  td [] [text (toString spot.properties.id) ]
        , td [] [ text (toString spot.geometry.coordinates) ]
        , td []
            []
        ]
