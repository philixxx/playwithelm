module EventMap.Models exposing (..)

import Spots.Models exposing (..)

type alias FeatureCollection =
    { features : List Spot
    }


type alias EventMap =
    { zoomLevel : Int
    , draw : FeatureCollection
    }


new : EventMap
new =
    { zoomLevel = 2
    , draw = newFC
    }


newFC : FeatureCollection
newFC =
    { features = [ Spots.Models.newS ]
    }
