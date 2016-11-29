module Spot.Update exposing (..)

import Spot.Messages exposing (..)
import Spot.Models exposing (..)
import Spot.Commands exposing (block, encodeProperties)
import Http exposing (Error(..))
import Leaflet.Ports
import Json.Encode as Json


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
