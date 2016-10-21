module SpotList.Update exposing (..)

import SpotList.Messages exposing (..)
import SpotList.Models exposing (..)
import Spot.Update exposing (..)


update : Msg -> SpotList -> ( SpotList, Cmd Msg )
update message spots =
    case message of
        SpotMsg subMsg ->
            let
                updatedList =
                    spots
                        |> List.map (Spot.Update.update subMsg)

                updatedSpots =
                    updatedList
                        |> List.map fst

                updatedCmds =
                    updatedList
                        |> List.map snd
            in
                ( updatedSpots, Cmd.map SpotList.Messages.SpotMsg (Cmd.batch updatedCmds) )
