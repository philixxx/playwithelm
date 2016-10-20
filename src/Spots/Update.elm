module Spots.Update exposing (..)

import Spots.Messages exposing (SpotListMessages(..))
import Spots.Models exposing (Spot)


update : SpotListMessages -> List Spot -> ( List Spot, Cmd SpotListMessages, String )
update message spots =
    case message of
        Select id ->
            ( spots, Cmd.none, id )

        Block id ->
            ( spots, Cmd.none, id )

        BlockFail error ->
            ( spots, Cmd.none, "merde" )

        BlockDone properties ->
            ( { spots | properties = properties }, Cmd.none, "Zuper" )
