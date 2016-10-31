module Spot.Messages exposing (..)

import Spot.Models exposing (..)
import Http


type Msg
    = Block
    | BlockDone BlockResponse
    | BlockFail Http.Error
    | Unblock
