module Maineu exposing (..)

import Html.App
import LabelEdit.View exposing (view)
import LabelEdit.Update exposing (update, Msg(..))
import LabelEdit.Models exposing (..)


init : ( SpoutList, Cmd Msg )
init =
    ( newSp, Cmd.none )


subscriptions : SpoutList -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
