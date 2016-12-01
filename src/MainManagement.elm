module Main exposing (..)

import Html.App
import Messages exposing (Msg(..))
import Management.Models exposing (Model, initialModel)
import Management.View exposing (view)
import Management.Update exposing (update)
import EventMap.Commands exposing (fetchAll)


type alias Flags =
    { mapendpoint : String
    }


initf : Flags -> ( Model, Cmd Msg )
initf flags =
    let
        cmds =
            Cmd.batch
                [ Cmd.map EventMsg (fetchAll (flags.mapendpoint))
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
        { init = initf
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
