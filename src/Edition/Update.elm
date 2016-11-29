module Edition.Update exposing (..)

import Messages exposing (Msg(..), EditMessage(..))
import Edition.Models exposing (Model)
import SpotList.Update exposing (..)
import EventMap.Update exposing (..)
import Edition.Commands exposing (..)
import EventMap.Commands exposing (encode)
import Leaflet.Ports
import Leaflet.Messages


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
                ( { model | eventMap = newEventMap }, Cmd.map SpotListMsg cmd )

        EditMsg subMsg ->
            case subMsg of
                SaveZoomLevel ->
                    ( model, Cmd.batch [ Cmd.map EditMsg (saveZoomLevel model.savezoomlevelendpoint model.eventMap) ] )

                ZoomLevelChanged level ->
                    let
                        map =
                            model.eventMap

                        newMap =
                            ({ map | zoomLevel = level })
                    in
                        ( { model | eventMap = newMap }, Cmd.none )

                SaveCenter ->
                    ( model, Cmd.batch [ Cmd.map EditMsg (saveCenter model.savecenterendpoint model.eventMap) ] )

                CenterChanged center ->
                    let
                        map =
                            model.eventMap

                        newMap =
                            ({ map | center = center })
                    in
                        ( { model | eventMap = newMap }, Cmd.none )

                LeafletSpotMsg subsubMsg ->
                    case subsubMsg of
                        Leaflet.Messages.SpotAdded spot ->
                            let
                                eventMap =
                                    model.eventMap

                                draw =
                                    eventMap.draw

                                features =
                                    draw.features

                                newFeatures =
                                    spot :: features

                                newDraw =
                                    { draw | features = newFeatures }

                                newEm =
                                    { eventMap | draw = newDraw }
                            in
                                ( { model | eventMap = newEm }, Cmd.none )

                        Leaflet.Messages.SpotRemoved spotId ->
                            let
                                eventMap =
                                    model.eventMap

                                draw =
                                    eventMap.draw

                                features =
                                    draw.features

                                newFeatures =
                                    List.filter
                                        (\spot ->
                                            if (not (spot.properties.id == spotId)) then
                                                True
                                            else
                                                False
                                        )
                                        features

                                newDraw =
                                    { draw | features = newFeatures }

                                newEm =
                                    { eventMap | draw = newDraw }
                            in
                                ( { model | eventMap = newEm }, Cmd.none )

                        otherwise ->
                            ( model, Cmd.none )

                otherwise ->
                    ( model, Cmd.none )

        otherwise ->
            ( model, Cmd.none )
