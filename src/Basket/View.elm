module Basket.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, id)
import Basket.Messages exposing (..)
import Basket.Models exposing (..)
import Set exposing (Set, toList)
import Html.Events exposing (onClick)


view : Basket -> Html Basket.Messages.Msg
view basket =
    div []
        [ div [ Html.Attributes.id "quotation" ] [ text (toString ((toFloat basket.quotation.quotation/100))) ]
        , div [ class "p2" ]
            [ table []
                [ thead []
                    [ tr []
                        [ th [] [ text "Id" ]
                        , th [] [ text "Supprimer" ]
                        ]
                    ]
                , tbody [] (viewBasket (toList basket.spots))
                ]
            ]
        ]


viewBasket : List String -> List (Html Basket.Messages.Msg)
viewBasket spots =
    List.map viewBasketLine spots


viewBasketLine : String -> Html Basket.Messages.Msg
viewBasketLine spotId =
    tr []
        [ td [] [ text (toString spotId) ]
        , button [ onClick (RemoveSpotFromBasket spotId), class "toto" ] [ text ("Supprimer") ]
        ]
