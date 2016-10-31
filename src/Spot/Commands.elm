module Spot.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Spot.Messages exposing (Msg(..))
import Spot.Models exposing (..)


blockOneUrl : Spot -> String
blockOneUrl spot =
    "http://localhost:5000/block?id=" ++ spot.properties.id


block : Spot -> Cmd Msg
block spot =
    Http.get blockDecoder (blockOneUrl spot)
        |> Task.perform BlockFail BlockDone


blockDecoder : Decode.Decoder SpotProperties
blockDecoder =
    Decode.object4
        SpotProperties
        ("Id" := Decode.string)
        ("SectorName" := Decode.string)
        ("SectorIndex" := Decode.int)
        ("Status" := Decode.string)
