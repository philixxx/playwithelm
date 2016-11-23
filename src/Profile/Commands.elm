module Profile.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Profile.Messages exposing (Msg(..))
import Profile.Models exposing (..)


fetchProfile : String -> Cmd Msg
fetchProfile endpoint =
    Http.get profilesDecoder endpoint
        |> Task.perform FetchProfileFail FetchProfileDone


profilesDecoder : Decode.Decoder Profile
profilesDecoder =
    Decode.object1 Profile
        ("profiles" := Decode.list (Decode.string))


profileDecoder : Decode.Decoder (List String)
profileDecoder =
    Decode.list (Decode.string)
