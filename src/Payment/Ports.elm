port module Payment.Ports exposing (..)

import Json.Encode exposing (..)
import Json.Encode exposing (Value)


port callReservation : Value -> Cmd msg
