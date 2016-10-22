module Spot.Update exposing (..)

import Spot.Messages exposing (..)
import Spot.Models exposing (..)


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
            ( changeStatus spot "BLOCKED", Cmd.none )

        Unblock ->
            ( changeStatus spot "AVAILABLE", Cmd.none )
