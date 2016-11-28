module Basket.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, id)
import Basket.Messages exposing (..)
import Basket.Models exposing (..)
import Html.Events exposing (onClick)
import Spot.Models exposing (Spot)


view : Basket -> Html Basket.Messages.Msg
view basket =
    div []
        [ div [ class "p2" ]
            [ table []
                [ thead []
                    [ tr []
                        [ th [] [ text "Id" ]
                        , th [] [ text "Supprimer" ]
                        ]
                    ]
                , tbody [] (viewBasket (basket.spots))
                ]
            ]
        ]


viewBasket : List Spot -> List (Html Basket.Messages.Msg)
viewBasket spots =
    List.map viewBasketLine spots


viewBasketLine : Spot -> Html Basket.Messages.Msg
viewBasketLine spot =
    tr []
        [ td [] [ text (toString spot.properties.id) ]
        , button [ onClick (RemoveSpotFromBasket spot), class "toto" ] [ text ("Supprimer") ]
        ]
