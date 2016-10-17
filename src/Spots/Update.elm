module Spots.Update exposing (..)

import Spots.Messages exposing (Msg(..))
import Spots.Models exposing (Spot)


update : Msg -> List Spot -> ( List Spot, Cmd Msg, String )
update message spots =
    case message of
        Select id ->
            ( spots, Cmd.none, id )
