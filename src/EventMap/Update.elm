module EventMap.Update exposing (..)

import EventMap.Messages exposing (Msg(..))
import EventMap.Models exposing (..)


update : Msg -> EventMap -> ( EventMap, Cmd Msg )
update message map =
    case message of
        FetchAllDone eventMap ->
            Debug.log ("OK C'est exec")
                ( eventMap, Cmd.none )

        FetchAllFail error ->
            Debug.crash ("Crash in eventMap Update" ++ toString error)
                ( map, Cmd.none )
