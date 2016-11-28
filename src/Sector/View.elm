module Sector.View exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (class)
import Spot.View
import Spot.Models exposing (Spot)
import Html.Events exposing (onInput, onClick)
import Sector.Messages exposing (..)


view : List Spot -> Html Msg
view spots =
    div []
        [ nav spots
        , list spots
        ]

nav : List Spot -> Html Msg
nav spots =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Spots" ] ]


viewOneSpot : Spot.Models.Spot -> Html Msg
viewOneSpot spot =
    Spot.View.viewedit spot
        |> Html.App.map (SpotMsg spot)


viewSpots : List Spot -> List (Html Msg)
viewSpots =
    List.map viewOneSpot


list : List Spot -> Html Msg
list spots =
    div [ class "p2" ]
        [ text (toString (List.length spots))
        , input [ onInput SectorNameChangeAll ] []
        , button [ onClick (SaveSpotsSector) ] [ text "Sauvegarder le secteur" ]
        , table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "SectorName" ]
                    , th [] [ text "SectorIndex" ]
                    ]
                ]
            , tbody [] (viewSpots spots)
            ]
        ]
