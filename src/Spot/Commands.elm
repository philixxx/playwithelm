module Spot.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Spot.Messages exposing (Msg(..))
import Spot.Models exposing (..)


blockOneUrl : Spot -> String
blockOneUrl spot =
    "http://localhost:8000/api/block/" ++ spot.properties.id


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
            Debug.log ("STATTTT" ++ status)
                Decode.succeed
                AVAILABLE

        "BLOCKED" ->
            Debug.log ("STATTTT" ++ status)
                Decode.succeed
                BLOCKED

        _ ->
            Debug.log ("STATTTT ERROR" ++ status)
                Decode.succeed
                UNKNOWN
