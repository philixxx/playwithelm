module Payment.Commands exposing (reservationEncoder)

import Json.Encode as Json
import Basket.Models exposing (..)
import Set exposing (toList)


reservationEncoder : Basket -> Json.Value
reservationEncoder basket =
    Json.object <|
        [ ( "profile", Json.string "PARTICULIER" )
        , ( "exhibitorStatus", Json.string "RESIDENT" )
        , ( "spots", List.map (Json.string) (toList basket.spots) |> Json.list )
        ]
