module EventMap.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Task
import EventMap.Models exposing (..)
import EventMap.Messages exposing (Msg(..))


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


spotsDecoder : Decode.Decoder (List Spot)
spotsDecoder =
    Decode.list spotDecode


spotDecode : Decode.Decoder Spot
spotDecode =
    Decode.object2 Spot
        ("properties" := propertiesDecode)
        ("geometry" := geometryDecode)


geometryDecode : Decode.Decoder SpotGeometry
geometryDecode =
    Decode.object1 SpotGeometry
        ("coordinates" := Decode.list (Decode.list (Decode.list Decode.float)))


propertiesDecode : Decode.Decoder SpotProperties
propertiesDecode =
    Decode.object3 SpotProperties
        ("Id" := Decode.string)
        ("SectorName" := Decode.string)
        ("SectorIndex" := Decode.int)
