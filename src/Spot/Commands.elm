module Spot.Commands exposing (..)

import Task
import Json.Decode as Decode exposing (field)
import Spot.Messages exposing (Msg(..))
import Spot.Models exposing (..)
import Http


blockOneUrl : Spot -> String
blockOneUrl spot =
    "http://localhost:5000/api/block/" ++ spot.properties.id


type Bla
    = LoadMetadata (Result Http.Error Metadata)


block : Spot -> Cmd Msg
block spot =
    Http.send (Bla) (blockOneUrl spot)


blockDecoder : Decode.Decoder BlockResponse
blockDecoder =
    Decode.map2
        BlockResponse
        (field "Id" Decode.string)
        (field "Status" Decode.string |> Decode.andThen statusDecoder)


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
