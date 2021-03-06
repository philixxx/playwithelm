module Spot.Update exposing (..)

import Spot.Messages exposing (..)
import Spot.Models exposing (..)
import Spot.Commands exposing (block, encodeProperties)
import Http exposing (Error(..))
import Leaflet.Ports
import Json.Encode as Json
import String exposing (..)


changeStatus : Spot -> SpotStatus -> Spot
changeStatus spot status =
    let
        props =
            spot.properties

        newProps =
            { props | status = status }
    in
        { spot | properties = newProps }


update : Msg -> Spot -> ( Spot, Cmd Msg )
update message spot =
    case message of
        Block ->
            ( changeStatus spot UNKNOWN, block spot )

        BlockDone blockResponse ->
            let
                newSpot =
                    changeStatus spot blockResponse.status
            in
                ( newSpot, Leaflet.Ports.spotPropertiesHasBeenUpdated ((encodeProperties newSpot.properties) |> Json.object) )

        BlockFail error ->
            case error of
                UnexpectedPayload errMsg ->
                    Debug.log ("In Error UnexpectedPayload" ++ errMsg)
                        ( changeStatus spot UNKNOWN, Cmd.none )

                NetworkError ->
                    Debug.log ("In Error NetworkError")
                        ( changeStatus spot UNKNOWN, Cmd.none )

                BadResponse code reason ->
                    Debug.log ("In Error code " ++ toString code ++ " Reason  :" ++ reason)
                        ( changeStatus spot UNKNOWN, Cmd.none )

                Timeout ->
                    Debug.log ("In Error Timeout")
                        ( changeStatus spot UNKNOWN, Cmd.none )

        Unblock ->
            let
                newSpot =
                    changeStatus spot AVAILABLE
            in
                ( newSpot, Leaflet.Ports.spotPropertiesHasBeenUpdated ((encodeProperties newSpot.properties) |> Json.object) )

        SectorIndexChange sectorIndex ->
            let
                updatedSpot =
                    changeSectorIndex spot sectorIndex
            in
                ( updatedSpot, Leaflet.Ports.spotPropertiesHasBeenUpdated ((encodeProperties updatedSpot.properties) |> Json.object) )

        SectorNameChange sectorName ->
            let
                updatedSpot =
                    changeSectorName spot sectorName
            in
                Debug.log("hello !!! ca marche")
                ( updatedSpot, Leaflet.Ports.spotPropertiesHasBeenUpdated ((encodeProperties updatedSpot.properties) |> Json.object) )


changeSectorIndex : Spot -> String -> Spot
changeSectorIndex spot sectIndex =
    let
        props =
            spot.properties

        newProps =
            { props | sectorIndex = (String.toInt sectIndex |> Result.toMaybe) }
    in
        { spot | properties = newProps }



changeSectorName : Spot -> String -> Spot
changeSectorName spot sectName =
    let
        props =
            spot.properties

        newProps =
            { props | sectorName = Just sectName }
    in
        { spot | properties = newProps }
