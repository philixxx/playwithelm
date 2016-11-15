module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Management.View exposing (view)
import Update exposing (update)
import EventMap.Commands exposing (fetchAll)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.map EventMsg fetchAll )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
