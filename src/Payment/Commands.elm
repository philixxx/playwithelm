module Payment.Commands exposing (reservationEncoder)

import Json.Encode as Json
import Basket.Models exposing (..)
import Set exposing (toList)


reservationEncoder : Basket -> String -> Json.Value
reservationEncoder basket profile =
    Json.object <|
        [ ( "profile", Json.string profile )
        , ( "exhibitorStatus", Json.string "RESIDENT" )
        , ( "spots", List.map (Json.string) (toList basket.spots) |> Json.list )
        ]
