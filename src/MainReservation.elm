module Main exposing (..)

import Html.App exposing (..)
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel, Flags)
import Reservation.View exposing (view)
import UpdateReservation exposing (update)
import EventMap.Commands exposing (fetchAll)
import Leaflet.Ports
import Basket.Messages


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel flags, Cmd.map EventMsg (fetchAll (flags.getmapendpoint)) )


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
                Basket.Messages.AddSpotToBasket
            else
                Basket.Messages.RemoveSpotFromBasket
    in
        (BasketMsg (msg id))



-- MAIN


main : Program Flags
main =
    Html.App.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
