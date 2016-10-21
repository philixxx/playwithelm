module Spot.Update exposing (..)

import Spot.Messages exposing (..)
import Spot.Models exposing (..)


update : Msg -> Spot -> ( Spot, Cmd Msg )
update message spot =
    case message of
        Block ->
            ( spot, Cmd.none )
