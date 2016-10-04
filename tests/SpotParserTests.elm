module SpotParserTests exposing (..)

import Test exposing (..)
import Expect
import String
import Http
import Json.Decode as Decode exposing (( := ))
import Task

import Spots.Commands exposing (..)
import Spots.Models exposing (Spot)


fakeSpot : String
fakeSpot =
     """{
             "type":"Feature",
             "properties":{"Id":"e91abcc9-d64c-4c78-93d0-b9afd3634d37", "SectorName" : "C", "SectorIndex" : 2},
             "geometry": {
                   "type": "Polygon",
                   "coordinates": [[[-3.726741671562195,
                48.085174445655085],
                [-3.7267059981823043,
                  48.085199888967665],
                [-3.7266865521669468,
                  48.08518779443685],
                [-3.7267222255468364,
                  48.08516235111829],
                [-3.726741671562195,
                  48.085174445655085]]]
              }
            }"""

fakeProperties : String
fakeProperties =
    """{"Id":"e91abcc9-d64c-4c78-93d0-b9afd3634d37", "SectorName" : "C", "SectorIndex" : 2}"""

fakeSpots : String
fakeSpots =
    """[
           {
             "type":"Feature",
             "properties":{"Id":"e91abcc9-d64c-4c78-93d0-b9afd3634d37", "SectorName" : "C", "SectorIndex" : 1},

              "geometry": {
                               "type": "Polygon",
                               "coordinates":[[[-3.726741671562195,
                   48.085174445655085],
                   [-3.7267059981823043,
                     48.085199888967665],
                   [-3.7266865521669468,
                     48.08518779443685],
                   [-3.7267222255468364,
                     48.08516235111829],
                   [-3.726741671562195,
                     48.085174445655085]]]
                  }
           },
           {
             "type":"Feature",
             "properties":{"Id":"e91abcc9-d64c-4c78-93d0-b9afd3634d37", "SectorName" : "C",  "SectorIndex" : 2},
               "geometry": {
                                "type": "Polygon",
                                "coordinates":
                                     [[[-3.726741671562195,
                   48.085174445655085],
                   [-3.7267059981823043,
                     48.085199888967665],
                   [-3.7266865521669468,
                     48.08518779443685],
                   [-3.7267222255468364,
                     48.08516235111829],
                   [-3.726741671562195,
                     48.085174445655085]]]
                   }
           }
         ]"""

all : Test

all =
    describe "A Test Suite"
        [ test "Spot decode message" <|
            \() ->
                case (Decode.decodeString spotDecode fakeSpot) of
                    Err msg ->
                        Expect.fail msg
                    Ok msg ->
                        Expect.pass
        ,test "Spot decode message correct fields setted" <|
            \() ->
                case (Decode.decodeString spotDecode fakeSpot) of
                    Err msg ->
                        Expect.fail msg
                    Ok msg ->
                        Expect.pass
        ,test "Spot decode properties" <|
            \() ->
                case (Decode.decodeString propertiesDecode fakeProperties) of
                    Err msg ->
                        Expect.fail msg
                    Ok msg ->
                        Expect.pass

        , test "Spots decode " <|
            \() ->
               case (Decode.decodeString spotsDecoder fakeSpots) of
                   Err msg ->
                       Expect.fail msg
                   Ok msg ->
                       Expect.pass
        ]
