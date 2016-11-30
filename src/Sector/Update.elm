module Sector.Update exposing (..)

import Sector.Models exposing (Sector)
import Spot.Models exposing (Spot)
import Sector.Commands exposing (..)
import Sector.Messages exposing (Msg(..))
import Leaflet.Ports exposing (updateSpotSelectStateTo, spotPropertiesHasBeenUpdated)
import Spot.Update exposing (..)
import Http exposing (Error(..))
import Json.Encode as Json
import Spot.Messages


getSpotListFromTuples listTuples =
    List.map
      (\(spot, cmd) ->
          spot) listTuples

getCmdListFromTuples listTuples =
    List.map
      (\(spot, cmd) ->
          Cmd.map (SpotMsg spot) cmd) listTuples


update : Msg -> Sector -> ( Sector, Cmd Msg )
update message model =
    case message of
        SectorNameChangeAll sectorName ->
            let
                listTuples =
                    List.map
                      (\s ->
                          Spot.Update.update (Spot.Messages.SectorNameChange sectorName) s
                      ) model.spots

                spotList = getSpotListFromTuples listTuples
                cmdList = getCmdListFromTuples listTuples
            in
                ( { model | spots = spotList } , Cmd.batch (cmdList) )

        SaveSpotsSector ->
            ( model, (saveSpotsSector model.savesectorendpoint model.spots) )

        SaveSpotsSectorDone response ->
            ( model, Cmd.none )

        SaveSpotsSectorFail error ->
            case error of
                UnexpectedPayload errMsg ->
                    Debug.log ("In Error UnexpectedPayload" ++ errMsg)
                    ( model, Cmd.none )

                NetworkError ->
                    Debug.log ("In Error NetworkError")
                    ( model, Cmd.none )

                BadResponse code reason ->
                    Debug.log ("In Error code " ++ toString code ++ " Reason  :" ++ reason)
                    ( model, Cmd.none )

                Timeout ->
                    Debug.log ("In Error Timeout")
                    ( model, Cmd.none )


        AddSpotToSector spot ->
            let
                newSpots =
                     model.spots ++ [spot]

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
