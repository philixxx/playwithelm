module Management.Update exposing (..)

import Messages exposing (Msg(..))
import Leaflet.Messages
import Leaflet.Ports
import Management.Models exposing (Model)
import EventMap.Update exposing (..)
import Spot.Models
import SpotList.Update
import EventMap.Commands exposing (encode)
import SpotList.Messages
import Sector.Update exposing (..)


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
                ( updatedList, cmd ) =
                    SpotList.Update.update subMsg model.selectedSpots
            in
                ( { model | selectedSpots = updatedList }, Cmd.map SpotListMsg cmd )

        SpotttClickedMsg subMsg ->
            case subMsg of
                Leaflet.Messages.SpotSelected spotId ->
                    callSelectedUpdateForSpot SpotList.Messages.AddSpotToList spotId model

                Leaflet.Messages.SpotUnselected spotId ->
                    callSelectedUpdateForSpot SpotList.Messages.RemoveSpotFromList spotId model

                otherwise ->
                    ( model, Cmd.none )

        otherwise ->
            ( model, Cmd.none )


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


callSelectedUpdateForSpot smg spotId model =
    let
        ( updatedList, cmd ) =
            case
                (find
                    (\spot ->
                        spot.properties.id == spotId
                    )
                    model.eventMap.draw.features
                )
            of
                Just a ->
                    SpotList.Update.update (smg a) model.selectedSpots

                Nothing ->
                    ( model.selectedSpots, Cmd.none )
    in
        ( { model | selectedSpots = updatedList }, Cmd.map SpotListMsg cmd )
