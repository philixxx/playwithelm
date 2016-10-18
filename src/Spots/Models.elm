module Spots.Models exposing (..)


type alias SpotId =
    String


type alias SpotProperties =
    { id : String
    , sectorName : String
    , sectorIndex : Int
    }


type alias Spot =
    { properties : SpotProperties
    , geometry : SpotGeometry
    }


type alias SpotGeometry =
    { coordinates : List (List (List Float))
    }


newS : Spot
newS =
    { properties = { id = "0", sectorName = "Z", sectorIndex = 0 }
    , geometry = { coordinates = [ [ [ 1.0 ] ] ] }
    }
