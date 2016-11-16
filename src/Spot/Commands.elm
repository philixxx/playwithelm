module Spot.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Spot.Messages exposing (Msg(..))
import Spot.Models exposing (..)


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
