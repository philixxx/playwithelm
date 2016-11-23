module Profile.View exposing (view)

import Html exposing (Html, select, option, text, div, button, node, table, thead, tr, th, tbody)
import Html.Attributes exposing (name, value)
import Html.Events exposing (onClick)
import Profile.Messages exposing (Msg(..), ProfileUpdatedMsg(..))
import Profile.Models exposing (Profile)
import Html.Attributes exposing (..)


view : Profile -> Html ProfileUpdatedMsg
view model =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (viewProfiles model.profiles)
            ]
        ]


viewProfiles : List String -> List (Html ProfileUpdatedMsg)
viewProfiles =
    List.map viewProfile


viewProfile : String -> Html ProfileUpdatedMsg
viewProfile profile =
    div []
        [ button [ onClick <| (ProfileSelected profile) ] [ text profile ]
        ]
