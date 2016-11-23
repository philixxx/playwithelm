module Profile.Messages exposing (..)

import Profile.Models exposing (..)
import Http


type Msg
    = FetchProfileFail Http.Error
    | FetchProfileDone Profile


type ProfileUpdatedMsg
    = ProfileSelected String
