module EventMap.Models exposing (..)

import SpotList.Models exposing (..)


type alias FeatureCollection =
    { features : SpotList.Models.SpotList
    }


type alias ZoomLevel =
    Int


type alias Center =
    { lat : Float
    , lng : Float
    }


type alias EventMap =
    { zoomLevel : ZoomLevel
    , center : Center
    , draw : FeatureCollection
    }


new : EventMap
new =
    { zoomLevel = 2
    , center = { lat = 0.0, lng = 0.0 }
    , draw = newFC
    }


newFC : FeatureCollection
newFC =
    { features = SpotList.Models.initialModel
    }
