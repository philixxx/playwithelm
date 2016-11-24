module Edition.Update exposing (..)

import Messages exposing (Msg(..))
import Edition.Models exposing (Model)
import SpotList.Update exposing (..)
import EventMap.Update exposing (..)
import Leaflet.Ports
import EventMap.Commands exposing (encode)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EventMsg subMsg ->
            let
                ( updatedMap, cmd ) =
                    EventMap.Update.update subMsg model.eventMap
            in
                ( { model | eventMap = updatedMap }, Leaflet.Ports.loadData (encode updatedMap) )

        SpotListMsg subMsg ->
            let
                ( updatedMap, cmd ) =
                    SpotList.Update.update subMsg model.eventMap.draw.features

                eventMap =
                    model.eventMap

                draw =
                    eventMap.draw

                newDraw =
                    { draw | features = updatedMap }

                newEventMap =
                    { eventMap | draw = newDraw }
            in
                Debug.log (toString cmd)
                    ( { model | eventMap = newEventMap }, Cmd.map SpotListMsg cmd )

        otherwise ->
            ( model, Cmd.none )
