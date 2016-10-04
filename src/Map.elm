import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Tab as Widget
import Logger

-- MODEL
type alias AppModel =
    { theTabModel : Widget.Model , theLoggerModel : Logger.Model  }


initialModel : AppModel
initialModel = {theTabModel = Widget.initialModel, theLoggerModel = Logger.initialModel}
init : ( AppModel, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- MESSAGES
type Msg = TabMsg Widget.Msg  | LogMsg Logger.Msg
-- UPDATE


update : Msg -> AppModel -> ( AppModel , Cmd Msg )
update message model =
    case message of
        TabMsg subMsg ->
            let
                ( updatedWidgetModel, widgetCmd ) =
                    Widget.update subMsg model.theTabModel
            in
                ( { model | theTabModel = updatedWidgetModel }, Cmd.map TabMsg widgetCmd )
        LogMsg subMsg ->
            let
                ( updatedWidgetModel, widgetCmd ) =
                    Logger.update subMsg model.theLoggerModel
            in
                ( { model | theLoggerModel = updatedWidgetModel }, Cmd.map LogMsg widgetCmd )

-- VIEW
view : AppModel -> Html Msg
view model =
    section [class "header"] [
        div []
        [
            node "style" [type' "text/css"] [ text styles ]
            , div [class "logger"]
                [ App.map LogMsg (Logger.view model.theLoggerModel)

                ]
             ,div []
                [
                App.map TabMsg (Widget.view model.theTabModel)

                ]
        ]]


-- SUBSCIPTIONS
subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
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
     .logger {
        position: fixed;
        bottom: 0;
     }
     """