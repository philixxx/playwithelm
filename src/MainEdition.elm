module Main exposing (..)

import Html.App
import Messages exposing (Msg(..))
import Edition.Models exposing (Model, initialModel, Flags)
import Edition.View exposing (view)
import Edition.Update exposing (update)
import EventMap.Commands exposing (fetchAll)


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        cmds =
            Cmd.batch
                [ Cmd.map EventMsg (fetchAll (flags.getmapendpoint))
                ]
    in
        ( initialModel flags, cmds )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Flags
main =
    Html.App.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
