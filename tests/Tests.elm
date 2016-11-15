module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Json.Decode as Decode exposing (( := ))
import Task


type alias User =
    { id : Int
    , name : String
    , username : String
    , email : String
    }

fake : String
fake =
    """{
  "id": 1,
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874",
    "geo": {
      "lat": "-37.3159",
      "lng": "81.1496"
    }
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net",
    "bs": "harness real-time e-markets"
  }
}"""
fake2 : String
fake2 =
    """{
  "id": 1,
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874",
    "geo": {
      "lat": "-37.3159",
      "lng": "81.1496"
    }
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net",
    "bs": "harness real-time e-markets"
  }
}"""
fakebadMail : String
fakebadMail =
    """{
  "id": 1,
  "name": "Leanne graham",
  "username": "Bret",
  "mail": "Sincere@april.biz",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874",
    "geo": {
      "lat": "-37.3159",
      "lng": "81.1496"
    }
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net",
    "bs": "harness real-time e-markets"
  }
}"""
type Msg
    = UserLoaded User
    | LoadingFailed String



loadUser : Int -> Cmd Msg
loadUser _ =
    Decode.decodeString userDecoder fake
        |> Task.fromResult
        |> Task.perform LoadingFailed UserLoaded


userDecoder : Decode.Decoder User
userDecoder =
    Decode.object4
        User
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("username" := Decode.string)
        ("email" := Decode.string)


all : Test

all =
    describe "A Test Suite"
        [ test "User decode message error if no mail" <|
            \() ->
                case (Decode.decodeString userDecoder fakebadMail) of
                    Err msg ->
                        Expect.pass
                    Ok msg ->
                        Expect.fail "It must be failed !"
        ,  test "User decode comparaison" <|
            \() ->
                Expect.equal ((Decode.decodeString userDecoder fake2)) ((Decode.decodeString userDecoder fake))
        , test "String.left" <|
            \() ->
                Expect.equal "a" (String.left 1 "abcdefg")


        ]
