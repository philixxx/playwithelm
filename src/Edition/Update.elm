module Edition.Update exposing (..)

import Messages exposing (Msg(..), EditMessage(..))
import Edition.Models exposing (Model)
import SpotList.Update exposing (..)
import EventMap.Update exposing (..)
import Edition.Commands exposing (..)
import EventMap.Commands exposing (encode)
import Leaflet.Ports
import Leaflet.Messages
import Sector.Messages
import Sector.Update
import Sector.Update exposing (..)


find : (a -> Bool) -> List a -> Maybe a
find predicate list =
    case list of
        [] ->
            Nothing

        first :: rest ->
            if predicate first then
                Just first
            else
                find predicate rest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EventMsg subMsg ->
            let
                ( updatedMap, cmd ) =
                    EventMap.Update.update subMsg model.eventMap
            in
                ( { model | eventMap = updatedMap }, Leaflet.Ports.loadData (encode updatedMap) )

        SectorMsg subMsg ->
            let
                ( updatedSector, cmd ) =
                    Sector.Update.update subMsg model.sector
            in
                ( { model | sector = updatedSector }, Cmd.map SectorMsg cmd )

        SpotttClickedMsg subMsg ->
            case subMsg of
                Leaflet.Messages.SpotSelected spotId ->
                    callSectorUpdateForSpot Sector.Messages.AddSpotToSector spotId model

                Leaflet.Messages.SpotUnselected spotId ->
                    callSectorUpdateForSpot Sector.Messages.RemoveSpotFromSector spotId model

                otherwise ->
                    ( model, Cmd.none )

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
                                ( { model | eventMap = newEm }, Cmd.map EditMsg (Edition.Commands.addSpot model.addSpotendpoint (spot)) )

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
                                ( { model | eventMap = newEm }, Cmd.map EditMsg (Edition.Commands.removeSpot model.removeSpotendpoint (spotId)) )

                        otherwise ->
                            ( model, Cmd.none )

                otherwise ->
                    ( model, Cmd.none )

        otherwise ->
            ( model, Cmd.none )


callSectorUpdateForSpot smg spotId model =
    let
        ( updatedSector, cmd ) =
            case
                (find
                    (\spot ->
                        spot.properties.id == spotId
                    )
                    model.eventMap.draw.features
                )
            of
                Just a ->
                    Sector.Update.update (smg a) model.sector

                Nothing ->
                    ( model.sector, Cmd.none )
    in
        ( { model | sector = updatedSector }, Cmd.map SectorMsg cmd )
