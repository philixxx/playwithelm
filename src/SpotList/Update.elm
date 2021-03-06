module SpotList.Update exposing (..)

import SpotList.Messages exposing (..)
import SpotList.Models exposing (..)
import Spot.Update exposing (..)
import Spot.Models exposing (Spot)
import Spot.Messages
import Leaflet.Ports exposing (updateSpotSelectStateTo)


updateSpot : Spot.Messages.Msg -> Spot.Models.Spot -> ( Spot.Models.Spot, Cmd Spot.Messages.Msg )
updateSpot msg spot =
    Spot.Update.update msg spot


update : Msg -> SpotList -> ( SpotList, Cmd Msg )
update message spots =
    case message of
        AddSpotToList spot ->
            let
                newSpots =
                     spots ++ [spot]
            in
                ( newSpots, Leaflet.Ports.updateSpotSelectStateTo ( spot.properties.id, "SELECTED" ) )

        RemoveSpotFromList spot ->
            let
                newSpots =
                    List.filter (\sp -> sp.properties.id /= spot.properties.id) spots
            in
                ( newSpots, Leaflet.Ports.updateSpotSelectStateTo ( spot.properties.id, "UNSELECTED" ) )


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
