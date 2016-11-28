module Main exposing (..)

import Html.App
import Messages exposing (Msg(..))
import Edition.Models exposing (Model, initialModel, Flags)
import Edition.View exposing (view)
import Edition.Update exposing (update)
import EventMap.Commands exposing (fetchAll)
import EventMap.Messages
import Leaflet.Ports
import EventMap.Models exposing (Center)
import Spot.Models exposing (newS)
import Spot.Commands exposing (spotDecode)
import Json.Decode exposing (decodeValue)


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        cmds =
            Cmd.batch
                [ Cmd.map EventMsg (fetchAll (flags.mapendpoint))
                ]
    in
        ( initialModel flags, cmds )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Leaflet.Ports.zoomLevelChanged zoomLevelChanged
        , Leaflet.Ports.centerChanged centerChanged
        , Leaflet.Ports.spotAdded spotAdded
        ]


zoomLevelChanged : Int -> Msg
zoomLevelChanged zoomLevel =
    EditMsg (Messages.ZoomLevelChanged zoomLevel)


centerChanged : Center -> Msg
centerChanged center =
    EditMsg (Messages.CenterChanged center)


spotAdded spot =
    let
        s =
            decodeValue spotDecode spot
    in
        case s of
            Ok a ->
                SpotAdded a

            Err error ->
                Debug.log ("Error when add" ++ error)
                    ErrorMsg
                    error



-- MAIN


main : Program Flags
main =
    Html.App.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
