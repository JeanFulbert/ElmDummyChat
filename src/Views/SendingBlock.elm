module Views.SendingBlock exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (Msg(..))
import Models exposing (..)
import EnterPressedDecoder exposing (..)

sendingBlock : User -> Html Msg
sendingBlock user =
    div [ class "sendingBlock" ]
        [ textarea [ onInput (PendingTextChanged user)
                   , onEnter (SendPending user)
                   , value user.pendingText ]
                   []
        , button [ onClick (SendPending user) ] [ text "OK" ]
        ]