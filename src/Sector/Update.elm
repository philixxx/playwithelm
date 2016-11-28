module Sector.Update exposing (..)

import Sector.Models exposing (Sector)
import Spot.Models exposing (Spot)
import Sector.Commands exposing (..)
import Sector.Messages exposing (Msg(..))
import Leaflet.Ports exposing (updateSpotSelectStateTo)
import Spot.Update exposing (..)


update : Msg -> Sector -> ( Sector, Cmd Msg )
update message model =
    case message of
        SectorNameChangeAll sectorName ->
            let
                updatedSpots =
                    changeSectorName model.spots sectorName
            in
                ( { model | spots = updatedSpots }, Cmd.none )

        SaveSpotsSector ->
            ( model, (saveSpotsSector model.savesectorendpoint model.spots) )

        AddSpotToSector spot ->
            let
                newSpots =
                    spot :: model.spots

                newModel =
                    { model | spots = newSpots }
            in
                ( newModel, Leaflet.Ports.updateSpotSelectStateTo ( spot.properties.id, "SELECTED" ) )

        RemoveSpotFromSector spot ->
            let
                newSpots =
                    List.filter (\sp -> sp.properties.id /= spot.properties.id) model.spots

                newModel =
                    { model | spots = newSpots }
            in
                ( newModel, Leaflet.Ports.updateSpotSelectStateTo ( spot.properties.id, "UNSELECTED" ) )

        SpotMsg spot subMsg ->
            let
                ( updatedSpot, cmd ) =
                    Spot.Update.update subMsg spot

                updatedSpots =
                    model.spots
                        |> List.map
                            (\s ->
                                if s.properties.id == spot.properties.id then
                                    updatedSpot
                                else
                                    s
                            )
            in
                ( { model | spots = updatedSpots }, Cmd.map (SpotMsg spot) cmd )

        otherwise ->
            ( model, Cmd.none )


changeSectorName : List Spot -> String -> List Spot
changeSectorName spots sectName =
    List.map
        (\spot ->
            let
                props =
                    spot.properties

                newProps =
                    { props | sectorName = Just sectName }
            in
                { spot | properties = newProps }
        )
        spots
