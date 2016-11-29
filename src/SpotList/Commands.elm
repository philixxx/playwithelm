module SpotList.Commands exposing (..)

import Json.Decode as Decode exposing ((:=))
import Spot.Models exposing (..)
import Spot.Commands exposing (spotDecode)


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
