module UpdateReservation exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import SpotList.Update exposing (..)
import EventMap.Update exposing (..)
import Profile.Update exposing (..)
import Basket.Update exposing (..)
import Quote.Update exposing (..)
import Leaflet.Ports
import Payment.Ports
import EventMap.Commands exposing (encode)
import Payment.Commands exposing (reservationEncoder)
import Quote.Commands exposing (fetchQuote)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EventMsg subMsg ->
            let
                ( updatedMap, cmd ) =
                    EventMap.Update.update subMsg model.eventMap
            in
                ( { model | eventMap = updatedMap }, Cmd.map EventMsg cmd )

        ProfileMsg subMsg ->
            let
                ( updateProfiles, cmd ) =
                    Profile.Update.update subMsg model.profile
            in
                ( { model | profile = updateProfiles }, Cmd.map ProfileMsg cmd )

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

        LoadData ->
            ( model
            , Leaflet.Ports.loadData (encode model.eventMap)
            )

        BasketMsg subMsg ->
            let
                ( updatedBasked, cmd ) =
                    Basket.Update.update subMsg model.basket
            in
                ( { model | basket = updatedBasked }, Cmd.map QuoteMsg (fetchQuote model.quote.url updatedBasked model.currentProfile) )

        QuoteMsg subMsg ->
            let
                ( updatedQuotation, cmd ) =
                    Quote.Update.update subMsg model.quotation
            in
                ( { model | quotation = updatedQuotation }, Cmd.none )

        ProfileUpdateMsg subMsg ->
            let
                ( updatedCurrentProfile, cmd ) =
                    Profile.Update.updateProfile subMsg model.currentProfile
            in
                ( { model | currentProfile = updatedCurrentProfile }, Cmd.map QuoteMsg (fetchQuote model.quote.url model.basket updatedCurrentProfile) )

        Pay ->
            ( model, Payment.Ports.callReservation (reservationEncoder model.basket model.currentProfile) )

        otherwise ->
            ( model, Cmd.none )
