module EventMap.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Task
import EventMap.Models exposing (..)
import EventMap.Messages exposing (Msg(..))
import SpotList.Models exposing (..)
import SpotList.Commands exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get mapDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:5000/map/"


mapDecoder : Decode.Decoder EventMap
mapDecoder =
    Decode.object2 EventMap
        ("Zoomlevel" := Decode.int)
        ("Draw" := featureCollectionDecoder)


featureCollectionDecoder : Decode.Decoder FeatureCollection
featureCollectionDecoder =
    Decode.object1 FeatureCollection
        ("features" := spotsDecoder)
