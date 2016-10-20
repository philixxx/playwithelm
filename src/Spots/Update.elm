module Spots.Update exposing (..)

import Spots.Messages exposing (SpotMessage(..))
import Spots.Messages exposing (SpotListMessage(..))
import Spots.Models exposing (Spot, SpotProperties)


update : SpotListMessage -> List Spot -> ( List Spot, Cmd SpotListMessage )
update message spots =
    case message of
        SPLMessage subMsg ->
            ( spots, Cmd.none )


updateSpot : SpotMessage -> Spot -> ( Spot, Cmd SpotMessage )
updateSpot message spot =
    case message of
        Block spot ->
            Debug.log ("BLAAAA")
                ( spot, Cmd.none )

        BlockFail error ->
            Debug.log ("ERROR ")
                ( spot, Cmd.none )

        BlockDone updatedProperties ->
            Debug.log ("Done ")
                ( spot, Cmd.none )
