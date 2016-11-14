module Basket.View exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (class)
import SpotList.Messages exposing (..)
import SpotList.Models exposing (..)
import Spot.View
import Spot.Models


view : SpotList -> Html SpotList.Messages.Msg
view spots =
    div []
        [ nav spots
        , list spots
        ]


nav : SpotList -> Html SpotList.Messages.Msg
nav spots =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Spots" ] ]



-- Solution bourrine
-- viewSpots : SpotList -> List (Html SpotList.Messages.Msg)
-- viewSpots spots =
--     spots
--         |> List.map (\spot -> spot |> Spot.View.view |> Html.App.map SpotMsg)
-- Solution plus claire
-- viewSpots : SpotList -> List (Html SpotList.Messages.Msg)
-- viewSpots spots =
--         |> List.map (Spot.View.view)
--         |> List.map (Html.App.map SpotMsg)
-- Solution ultime en point-free notation de ouf
-- viewSpots : SpotList -> List (Html SpotList.Messages.Msg)
-- viewSpots =
--     List.map (Spot.View.view >> Html.App.map SpotMsg)


viewSpot : Spot.Models.Spot -> Html SpotList.Messages.Msg
viewSpot spot =
    Spot.View.view spot
        |> Html.App.map (SpotMsg spot)


viewSpots : SpotList -> List (Html SpotList.Messages.Msg)
viewSpots =
    List.map viewSpot


list : SpotList -> Html SpotList.Messages.Msg
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
            , tbody [] (viewSpots spots)
            ]
        ]
