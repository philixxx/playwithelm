module Spots.Messages exposing (..)

import Spots.Models exposing (SpotProperties, Spot)
import Http


type SpotListMessage
    = SPLMessage SpotMessage


type SpotMessage
    = Block Spot
    | BlockFail Http.Error
    | BlockDone SpotProperties
