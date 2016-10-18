module Tab exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
    { count : Int
    , section : List String
    }


initialModel : Model
initialModel =
    { count = 3
    , section = [ "Tronçon1", "Tronçon2" ]
    }



-- MESSAGES


type Msg
    = Increase



-- VIEW


renderSection : String -> Html Msg
renderSection name =
    li [ class "collection-item" ] [ text <| "#" ++ name ]


renderSections : List String -> Html Msg
renderSections section =
    let
        lineItems =
            List.map renderSection section
    in
        ul [ class "collection" ] lineItems


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increase ] [ text "Ajouter tronçon" ]
        , div [] [ renderSections model.section ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Increase ->
            ( { model
                | section = List.append model.section [ "Tronçon" ++ toString model.count ]
                , count = model.count + 1
              }
            , Cmd.none
            )
