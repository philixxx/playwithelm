module EventMap.Messages exposing (..)

import Http
import EventMap.Models exposing (EventMap)


type Msg
    = FetchAllDone EventMap
    | FetchAllFail Http.Error