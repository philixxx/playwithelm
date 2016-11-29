module Spot.Models exposing (..)


type alias SpotId =
    String


type alias SpotProperties =
    { id : String
    , sectorName : Maybe String
    , sectorIndex : Maybe Int
    , status : SpotStatus
    }


type alias SpotGeometry =
    { coordinates : List (List (List Float))
    }


type alias Spot =
    { properties : SpotProperties
    , geometry : SpotGeometry
    }


newS : Spot
newS =
    { properties = { id = "0", sectorName = Just "Z", sectorIndex = Just 0, status = UNKNOWN }
    , geometry = { coordinates = [ [ [ 1.0 ] ] ] }
    }


type alias BlockResponse =
    { id : SpotId
    , status : SpotStatus
    }


type SpotStatus
    = BLOCKED
    | AVAILABLE
    | UNKNOWN
