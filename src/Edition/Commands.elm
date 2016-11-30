module Edition.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))
import Json.Encode as Json
import EventMap.Commands exposing (..)
import Messages exposing (EditMessage(..))
import EventMap.Models exposing (..)
import Spot.Commands
import Spot.Models exposing (Spot, SpotId)


type alias Rien =
    { result : String
    }


addSpot : String -> Spot -> Cmd EditMessage
addSpot endpoint spot =
    Http.post decodeNothing endpoint (Http.string (Json.encode 0 (Spot.Commands.encodeFeature spot |> Json.object)))
        |> Task.perform AddSpotFailed AddSpotDone


removeSpot : String -> SpotId -> Cmd EditMessage
removeSpot endpoint spotId =
    Http.post decodeNothing endpoint (Http.string (Json.string spotId |> Json.encode 0))
        |> Task.perform AddSpotFailed AddSpotDone


saveZoomLevel : String -> EventMap -> Cmd EditMessage
saveZoomLevel endpoint em =
    Http.post decodeNothing endpoint (Http.string (Json.int em.zoomLevel |> Json.encode 0))
        |> Task.perform SaveZoomLevelFail SaveZoomLevelDone


saveCenter : String -> EventMap -> Cmd EditMessage
saveCenter endpoint em =
    Http.post decodeNothing endpoint (Http.string (centerEncoder em.center |> Json.encode 0))
        |> Task.perform SaveCenterFail SaveCenterDone


decodeNothing : Decode.Decoder Rien
decodeNothing =
    Decode.object1 Rien
        ("result" := Decode.string)


centerEncoder : Center -> Json.Value
centerEncoder center =
    Json.object <|
        [ ( "lat", Json.float center.lat )
        , ( "lng", Json.float center.lng )
        ]
