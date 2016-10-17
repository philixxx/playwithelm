module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Spots.Update exposing (..)
import EventMap.Update exposing (..)
import Leaflet.Ports


update msg model =
    case msg of
        EventMsg subMsg ->
            let
                ( updatedMap, cmd ) =
                    EventMap.Update.update subMsg model.eventMap
            in
                Debug.log "WAAAT1??"
                    ( { model | eventMap = updatedMap }, Cmd.map EventMsg cmd )

        SpotsMsg subMsg ->
            let
                ( updatedMap, cmd, id ) =
                    Spots.Update.update subMsg model.eventMap.draw.features
            in
                ( model, Leaflet.Ports.selectPlace (id) )

        SetLatLng latLng ->
            ( { model | latLng = latLng }
              -- Let's just assume that we'll have a `Leaflet.Ports` module that lets us use something like the built in API
            , Leaflet.Ports.setView ( latLng, 13, model.zoomPanOptions )
            )

        LoadData ->
            ( model
            , Leaflet.Ports.loadData ()
            )
