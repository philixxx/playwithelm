module Profile.Update exposing (..)

import Profile.Messages exposing (..)
import Profile.Models exposing (..)


update : Msg -> Profile -> ( Profile, Cmd Msg )
update msg model =
    case msg of
        FetchProfileFail err ->
            Debug.log ("FetchProfileFail : " ++ toString err)
                ( model, Cmd.none )

        FetchProfileDone newprofile ->
            Debug.log ("FetchProfileDone")
                ( newprofile, Cmd.none )


updateProfile : ProfileUpdatedMsg -> String -> ( String, Cmd ProfileUpdatedMsg )
updateProfile msg model =
    case msg of
        ProfileSelected profile ->
            Debug.log ("BLLLLLLLLLLLLLLLll")
                ( profile, Cmd.none )
