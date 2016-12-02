module SpotList.Messages exposing (..)

import Spot.Messages
import Spot.Models exposing (..)


type Msg
    = SpotMsg Spot Spot.Messages.Msg
    | AddSpotToList Spot
    | RemoveSpotFromList Spot
