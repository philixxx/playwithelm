module Payment.Commands exposing (reservationEncoder)

import Json.Encode as Json
import Basket.Models exposing (..)
import Spot.Models exposing (Spot)


reservationEncoder : Basket -> String -> Json.Value
reservationEncoder basket profile =
    Json.object <|
        [ ( "profile", Json.string profile )
        , ( "exhibitorStatus", Json.string "RESIDENT" )
        , ( "spots", List.map (Json.string) (extractIdOfSpots basket.spots) |> Json.list )
        ]


extractIdOfSpots : List Spot -> List String
extractIdOfSpots spots =
    List.map (\spot -> spot.properties.id) spots
