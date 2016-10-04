module Spots.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (( := ))
import Task
import Spots.Models exposing (..)

import Spots.Messages exposing (..)
--
--fetchAll : Cmd Msg
--fetchAll =
--    Http.get spotsDecoder fetchAllUrl
--        |> Task.perform FetchAllFail FetchAllDone
--
--fetchAllUrl : String
--fetchAllUrl =
--    "http://localhost:4000/Draw/"


spotsDecoder : Decode.Decoder (List Spot)
spotsDecoder =
    Decode.list spotDecode

spotDecode : Decode.Decoder Spot
spotDecode =
    Decode.object2 Spot
        ("properties" := propertiesDecode)
        ("geometry" := geometryDecode )


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
