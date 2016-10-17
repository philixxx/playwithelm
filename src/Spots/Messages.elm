module Spots.Messages exposing (..)

import Http
import Spots.Models exposing (SpotId, Spot)


type Msg
    = Select String