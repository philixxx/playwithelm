module EventMap.Models exposing (..)

import SpotList.Models exposing (..)


type alias FeatureCollection =
    { features : SpotList.Models.SpotList
    }


type alias ZoomLevel =
    Int


type alias EventMap =
    { zoomLevel : ZoomLevel
    , draw : FeatureCollection
    }


new : EventMap
new =
    { zoomLevel = 2
    , draw = newFC
    }


newFC : FeatureCollection
newFC =
    { features = SpotList.Models.initialModel
    }
