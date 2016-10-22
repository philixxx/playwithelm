module Spot.Update exposing (..)

import Spot.Messages exposing (..)
import Spot.Models exposing (..)


update : Msg -> Spot -> ( Spot, Cmd Msg )
update message spot =
    case message of
        Block ->
            let
                props =
                    spot.properties

                newProps =
                    { props | status = "BLOCKED" }
            in
                ( { spot | properties = newProps }, Cmd.none )

        Unblock ->
            let
                props =
                    spot.properties

                newProps =
                    { props | status = "AVAILABLE" }
            in
                ( { spot | properties = newProps }, Cmd.none )
