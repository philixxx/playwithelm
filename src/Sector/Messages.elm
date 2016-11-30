module Sector.Messages exposing (..)

import Spot.Models exposing (..)
import Spot.Messages exposing (..)
import Http


type Msg
    = SectorNameChangeAll String
    | SaveSpotsSector
    | SaveSpotsSectorFail Http.Error
    | SaveSpotsSectorDone { result : String }
    | SpotMsg Spot Spot.Messages.Msg
    | AddSpotToSector Spot
    | RemoveSpotFromSector Spot
