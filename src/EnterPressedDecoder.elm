module EnterPressedDecoder exposing (onEnter)

import Html exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Json.Decode as Json

type alias CodeAndShift =
     { code : Int
     , shift : Bool
     }

enterKey : Int
enterKey = 13

keyCodeAndShift : Json.Decoder CodeAndShift
keyCodeAndShift =
    Json.map2 CodeAndShift
        (Json.field "keyCode" Json.int)
        (Json.field "shiftKey" Json.bool)

onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnterAndShift { code, shift } =
            if code == enterKey && not shift then
                Json.succeed msg
            else
                Json.fail "NOPE"
    in
        on "keydown" (Json.andThen isEnterAndShift keyCodeAndShift)