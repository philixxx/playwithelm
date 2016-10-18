module Logger exposing (..)

import Html exposing (..)


-- MODEL


type alias Model =
    { lines : List String
    , count : Int
    }


initialModel : Model
initialModel =
    { lines = [ "Log : App loaded" ]
    , count = 1
    }



-- MESSAGES


type Msg
    = EventError
    | EventInfo



-- VIEW


renderLog : String -> Html Msg
renderLog line =
    div [] [ text <| "#" ++ line ]


renderLogs : List String -> Html Msg
renderLogs logs =
    let
        logItems =
            List.map renderLog logs
    in
        div [] logItems


view : Model -> Html Msg
view model =
    div []
        [ div [] [ renderLogs model.lines ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        EventError ->
            ( { model
                | lines = List.append model.lines [ "Log : " ++ toString model.count ]
                , count = model.count + 1
              }
            , Cmd.none
            )

        EventInfo ->
            ( { model
                | lines = List.append model.lines [ "Log Info: " ++ toString model.count ]
                , count = model.count + 1
              }
            , Cmd.none
            )
