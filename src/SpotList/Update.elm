module SpotList.Update exposing (..)

import SpotList.Messages exposing (..)
import SpotList.Models exposing (..)
import Spot.Update exposing (..)
import Spot.Models
import Spot.Messages


updateSpot : Spot.Messages.Msg -> Spot.Models.Spot -> ( Spot.Models.Spot, Cmd Spot.Messages.Msg )
updateSpot msg spot =
    Spot.Update.update msg spot


update : Msg -> SpotList -> ( SpotList, Cmd Msg )
update message spots =
    case message of
        SpotMsg spot subMsg ->
            let
                ( newSpot, cmd ) =
                    updateSpot subMsg spot

                updatedSpots =
                    spots
                        |> List.map
                            (\s ->
                                if s.properties.id == spot.properties.id then
                                    newSpot
                                else
                                    s
                            )
            in
                ( updatedSpots, Cmd.map (SpotList.Messages.SpotMsg spot) cmd )
