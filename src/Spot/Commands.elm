module Spot.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Spot.Messages exposing (Msg(..))
import Spot.Models exposing (..)
import Json.Encode as Json


blockOneUrl : Spot -> String
blockOneUrl spot =
    "http://localhost:5000/api/block/" ++ spot.properties.id


block : Spot -> Cmd Msg
block spot =
    Http.get blockDecoder (blockOneUrl spot)
        |> Task.perform BlockFail BlockDone


blockDecoder : Decode.Decoder BlockResponse
blockDecoder =
    Decode.object2
        BlockResponse
        ("Id" := Decode.string)
        ("Status" := Decode.string `Decode.andThen` statusDecoder)


statusDecoder : String -> Decode.Decoder SpotStatus
statusDecoder status =
    case status of
        "AVAILABLE" ->
            Decode.succeed
                AVAILABLE

        "BLOCKED" ->
            Decode.succeed
                BLOCKED

        _ ->
            Debug.log ("TODO implements status " ++ status)
                Decode.succeed
                UNKNOWN


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
        (Decode.maybe ("SectorName" := Decode.string))
        (Decode.maybe ("SectorIndex" := Decode.int))
        (Decode.oneOf [ ("Status" := Decode.string `Decode.andThen` statusDecoder), Decode.succeed UNKNOWN ])


encodeFeature : Spot -> List ( String, Json.Value )
encodeFeature { properties, geometry } =
    [ ( "type", Json.string "Feature" )
    , ( "geometry", encodeGeometry geometry |> Json.object )
    , ( "properties", encodeProperties properties |> Json.object )
    ]


encodeGeometry : SpotGeometry -> List ( String, Json.Value )
encodeGeometry { coordinates } =
    [ ( "type", Json.string "Polygon" )
    , ( "coordinates", coordinates |> List.map (List.map encodePosition >> Json.list) |> Json.list )
    ]


convertStatusToString : SpotStatus -> Json.Value
convertStatusToString status =
    case status of
        AVAILABLE ->
            Json.string "AVAILABLE"

        BLOCKED ->
            Json.string "BLOCKED"

        UNKNOWN ->
            Json.string "UNKNOWN"


encodeProperties : SpotProperties -> List ( String, Json.Value )
encodeProperties properties =
    [ ( "Id", Json.string properties.id )
    , ( "SectorIndex", Json.int (Maybe.withDefault -1 properties.sectorIndex) )
    , ( "SectorName", Json.string (Maybe.withDefault "" properties.sectorName) )
    , ( "Status", convertStatusToString properties.status )
    ]

encodePosition : List Float -> Json.Value
encodePosition position =
    position
        |> List.map Json.float
        |> Json.list
