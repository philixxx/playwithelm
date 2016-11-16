module Main exposing (..)

import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Reservation.View exposing (view)
import UpdateReservation exposing (update)
import EventMap.Commands exposing (fetchAll)
import Leaflet.Ports
import Basket.Messages


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.map EventMsg fetchAll )


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


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
