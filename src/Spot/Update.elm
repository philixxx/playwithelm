module Spot.Update exposing (..)

import Spot.Messages exposing (..)
import Spot.Models exposing (..)
import Spot.Commands exposing (block)


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
            Debug.log ("In Error")
                ( changeStatus spot "ERROR", Cmd.none )

        Unblock ->
            ( changeStatus spot "AVAILABLE", Cmd.none )
