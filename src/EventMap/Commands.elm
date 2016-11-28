module EventMap.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Task
import EventMap.Models exposing (..)
import EventMap.Messages exposing (Msg(..))
import SpotList.Models exposing (..)
import SpotList.Commands exposing (..)
import Json.Encode as Json
import Spot.Models exposing (..)


fetchAll : String -> Cmd Msg
fetchAll fetchAllUrl =
    Http.get mapDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


mapDecoder : Decode.Decoder EventMap
mapDecoder =
    Decode.object3 EventMap
        ("Zoomlevel" := Decode.int)
        ("Center" := decodeCenter)
        ("Draw" := featureCollectionDecoder)


decodeCenter : Decode.Decoder Center
decodeCenter =
    Decode.object2
        Center
        ("lat" := Decode.float)
        ("lng" := Decode.float)


featureCollectionDecoder : Decode.Decoder FeatureCollection
featureCollectionDecoder =
    Decode.object1 FeatureCollection
        ("features" := spotsDecoder)


encode : EventMap -> Json.Value
encode eventmap =
    Json.object <| encodeEventMap eventmap


encodeEventMap : EventMap -> List ( String, Json.Value )
encodeEventMap eventmap =
    let
        feat =
            eventmap.draw.features
    in
        [ ( "Zoomlevel", Json.int eventmap.zoomLevel )
        , ( "Center", encodeCenter eventmap.center |> Json.object )
        , ( "Draw", encodeFeatureCollection feat |> Json.object )
        ]


encodeCenter : Center -> List ( String, Json.Value )
encodeCenter center =
    [ ( "lng", Json.float center.lng )
    , ( "lat", Json.float center.lat )
    ]


encodeFeatureCollection : SpotList -> List ( String, Json.Value )
encodeFeatureCollection spotList =
    [ ( "type", Json.string "FeatureCollection" )
    , ( "features", List.map (encodeFeature >> Json.object) spotList |> Json.list )
    ]


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
