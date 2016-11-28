module Sector.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Json
import Sector.Messages exposing (Msg(..))
import Spot.Models exposing (Spot)


type alias Rien =
    { result : String
    }


saveSpotsSector : String -> List Spot -> Cmd Msg
saveSpotsSector endpoint spots =
  Cmd.batch ( List.map (saveSpotSector endpoint) spots )


saveSpotSector : String -> Spot -> Cmd Msg
saveSpotSector endpoint spot =
  Http.post decodeNothing endpoint (Http.string ("bla"))
        |> Task.perform SaveSpotsSectorFail SaveSpotsSectorDone


decodeNothing : Decode.Decoder Rien
decodeNothing =
    Decode.object1 Rien
        ("result" := Decode.string)
