import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)



type alias Model = { firstCommit : String}
type Msg = NoOp

initialModel = {firstCommit = "initial commit" }

update : Msg -> Model -> Model
update msg model =  model

view : Model -> Html Msg
view model =
  div []
  [
   node "style" [type' "text/css"] [ text styles ]
  , section [class "hello"]
    [ header [class "header"]
      [ h1 [] [text model.firstCommit]
      ]
    ]
  ]



main = App.beginnerProgram {model = initialModel , view = view, update = update}


styles : String
styles =
     """
     html,
     body {
       margin: 0;
       padding: 0;
     }
     button {
       margin: 0;
       padding: 0;
       border: 0;
       background: none;
       font-size: 100%;
       vertical-align: baseline;
       font-family: inherit;
       font-weight: inherit;
       color: inherit;
       -webkit-appearance: none;
       appearance: none;
       -webkit-font-smoothing: antialiased;
       -moz-osx-font-smoothing: grayscale;
     }
     """