module Spot.Update exposing (..)

import Spot.Messages exposing (..)
import Spot.Models exposing (..)
import Spot.Commands exposing (block)
import Http exposing (Error(..))


changeStatus : Spot -> String -> Spot
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
            ( changeStatus spot "BLOCKING", block spot )

        BlockDone spotProperties ->
            ( changeStatus spot "BLOCKED", Cmd.none )

        BlockFail error ->
            case error of
                UnexpectedPayload errMsg ->
                    Debug.log ("In Error" ++ errMsg)
                        ( changeStatus spot "ERROR", Cmd.none )

                NetworkError ->
                    Debug.log ("In Error")
                        ( changeStatus spot "ERROR", Cmd.none )

                BadResponse a b ->
                    Debug.log ("In Error")
                        ( changeStatus spot "ERROR", Cmd.none )

                Timeout ->
                    Debug.log ("In Error")
                        ( changeStatus spot "ERROR", Cmd.none )

        Unblock ->
            ( changeStatus spot "AVAILABLE", Cmd.none )
