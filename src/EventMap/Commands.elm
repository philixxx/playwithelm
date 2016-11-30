module EventMap.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Task
import EventMap.Models exposing (..)
import EventMap.Messages exposing (Msg(..))
import SpotList.Models exposing (..)
import SpotList.Commands exposing (..)
import Json.Encode as Json
import Spot.Commands exposing (..)


fetchAll : String -> Cmd Msg
fetchAll fetchAllUrl =
    Http.get mapDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


mapDecoder : Decode.Decoder EventMap
mapDecoder =
    Decode.object3 EventMap
        ("Zoomlevel" := Decode.oneOf [ Decode.int, Decode.null 6 ])
        ("Center" := Decode.oneOf [ decodeCenter, Decode.null { lat = 46.807579571992385, lng = 6.1083984375 } ])
        ("Draw" := featureCollectionDecoder)


decodeCenter : Decode.Decoder Center
decodeCenter =
    Decode.object2
        Center
        ("lat" := Decode.oneOf [ Decode.float, Decode.null 46.807579571992385 ])
        ("lng" := Decode.oneOf [ Decode.float, Decode.null 6.1083984375 ])


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
