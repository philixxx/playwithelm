module Spots.Messages exposing (..)

import Spots.Models exposing (SpotProperties)
import Http


type SpotListMessages
    = Select String
    | Block String
    | BlockFail Http.Error
    | BlockDone SpotProperties
