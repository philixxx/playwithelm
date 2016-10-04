module EventMap.Models exposing (..)

type alias FeatureCollection =
    {
        features : List Spot
    }

type alias EventMap =
    {
     zoomLevel : Int
     , draw : FeatureCollection

    }



type alias SpotId =
    String




type alias SpotProperties =
 {
    id : String

    , sectorName : String
    , sectorIndex : Int
 }

type alias Spot =
    { properties : SpotProperties
    , geometry : SpotGeometry
    }

type alias SpotGeometry =
    {
        coordinates : List (List (List Float))
    }

newS : Spot
newS =
    { properties = {id = "0", sectorName ="Z", sectorIndex = 0}
    , geometry = {coordinates = [[[1.0]]]}
    }



new : EventMap
new =
    {
        zoomLevel = 2
        ,draw = newFC


    }

newFC : FeatureCollection
newFC =
    {
        features = [newS]
    }