module Spot.Models exposing (..)


type alias SpotId =
    String


type alias SpotProperties =
    { id : String
    , sectorName : String
    , sectorIndex : Int
    , status : String
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
    { properties = { id = "0", sectorName = "Z", sectorIndex = 0, status = "TODO" }
    , geometry = { coordinates = [ [ [ 1.0 ] ] ] }
    }
