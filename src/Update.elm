module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import EventMap.Models exposing (EventMap)
import Spots.Update exposing (..)
import EventMap.Update exposing (..)
import Leaflet.Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EventMsg subMsg ->
            let
                ( updatedMap, cmd ) =
                    EventMap.Update.update subMsg model.eventMap
            in
                Debug.log "WAAAT1??"
                    ( { model | eventMap = updatedMap }, Cmd.map EventMsg cmd )

        SpotMsgParent subMsg ->
            let
                ( updatedMap, cmd ) =
                    bla subMsg model.eventMap
            in
                Debug.log "WAAAT1??"
                    ( { model | eventMap = updatedMap }, Cmd.none )

        SetLatLng latLng ->
            ( { model | latLng = latLng }
              -- Let's just assume that we'll have a `Leaflet.Ports` module that lets us use something like the built in API
            , Leaflet.Ports.setView ( latLng, 13, model.zoomPanOptions )
            )

        LoadData ->
            ( model
            , Leaflet.Ports.loadData ()
            )


bla msg eventmap =
    let
        ( sp, cmd ) =
            Spots.Update.update msg eventmap.featureCollection
    in
        ( { eventmap | featureCollection = sp }, Cmd.none )
