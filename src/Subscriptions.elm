module Subscriptions exposing (subscriptions)

import Messages exposing (..)
import Models exposing (..)
import Keys
import Keyboard exposing (..)

notifyShiftChange : Bool -> Int -> Msg
notifyShiftChange isShiftDown keyCode =
    if keyCode == Keys.shift
    then ShiftKeyDown isShiftDown
    else NoMessage

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs <| notifyShiftChange True
        , Keyboard.ups <| notifyShiftChange False
        ]