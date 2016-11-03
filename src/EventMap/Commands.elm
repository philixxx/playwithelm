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


fetchAll : Cmd Msg
fetchAll =
    Http.get mapDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:5000/map/"


mapDecoder : Decode.Decoder EventMap
mapDecoder =
    Decode.object3 EventMap
        ("Zoomlevel" := Decode.int)
        ("Center" := decodeCenter)
        ("Draw" := featureCollectionDecoder)


decodeCenter : Decode.Decoder Center
decodeCenter =
    Decode.object2 Center
        ("lng" := Decode.float)
        ("lat" := Decode.float)


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
        [ ( "ZoomLevel", Json.int eventmap.zoomLevel )
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
    let
        ( fakeProperties, fakeGeometry ) =
            ( Json.object
                [ ( "id", Json.string "vla" )
                , ( "sectorIndex", Json.int 42 )
                , ( "sectorName", Json.string "bli" )
                , ( "status", Json.string "AVAILABLE" )
                ]
            , Json.object []
            )
    in
        [ ( "type", Json.string "Feature" )
        , ( "geometry", encodeGeometry geometry |> Json.object )
        , ( "properties", fakeProperties )
        ]


encodeGeometry : SpotGeometry -> List ( String, Json.Value )
encodeGeometry { coordinates } =
    [ ( "type", Json.string "Polygon" )
    , ( "coordinates", coordinates |> List.map (List.map encodePosition >> Json.list) |> Json.list )
    ]


encodePosition : List Float -> Json.Value
encodePosition position =
    position
        |> List.map Json.float
        |> Json.list
