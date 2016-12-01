module Main exposing (..)

import Html.App exposing (..)
import Messages exposing (Msg(..))
import Reservation.Models exposing (Model, initialModel, Flags)
import Reservation.View exposing (view)
import Reservation.UpdateReservation exposing (update)
import EventMap.Commands exposing (fetchAll)
import Profile.Commands exposing (fetchProfile)
import Leaflet.Ports
import Leaflet.Messages


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        cmds =
            Cmd.batch
                [ Cmd.map EventMsg (fetchAll (flags.mapendpoint))
                , Cmd.map ProfileMsg (fetchProfile (flags.eventendpoint ++ "/profiles"))
                ]
    in
        ( initialModel flags, cmds )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Leaflet.Ports.spotActionOn mapJsMsg
        ]


mapJsMsg : ( String, String ) -> Msg
mapJsMsg ( action, id ) =
    let
        msg =
            if action == "SELECTED" then
                Leaflet.Messages.SpotSelected
            else
                Leaflet.Messages.SpotUnselected
    in
        (SpotttClickedMsg (msg id))



-- MAIN


main : Program Flags
main =
    Html.App.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
