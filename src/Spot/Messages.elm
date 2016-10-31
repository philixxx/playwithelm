module Spot.Messages exposing (..)

import Spot.Models exposing (..)
import Http


type Msg
    = Block
    | BlockDone SpotProperties
    | BlockFail Http.Error
    | Unblock
