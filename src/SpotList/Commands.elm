module SpotList.Commands exposing (..)

import Json.Decode as Decode exposing ((:=))
import Spot.Models exposing (..)
import Spot.Commands exposing (..)


--
--fetchAll : Cmd Msg
--fetchAll =
--    Http.get spotsDecoder fetchAllUrl
--        |> Task.perform FetchAllFail FetchAllDone
--
--fetchAllUrl : String
--fetchAllUrl =
--    "http://localhost:4000/Draw/"
--
--
-- blockOne : Cmd SpotList.Messages.Msg
-- blockOne =
--     Http.get propertiesDecode blockOneUrl
--         |> Task.perform BlockFail BlockDone


spotsDecoder : Decode.Decoder (List Spot.Models.Spot)
spotsDecoder =
    Decode.list spotDecode


spotDecode : Decode.Decoder Spot.Models.Spot
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
    Decode.object4 SpotProperties
        ("Id" := Decode.string)
        ("SectorName" := Decode.string)
        ("SectorIndex" := Decode.int)
        ("Status" := Decode.string `Decode.andThen` statusDecoder)
