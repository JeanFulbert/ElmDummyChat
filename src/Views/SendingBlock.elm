module Views.SendingBlock exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (Msg(..))
import Models exposing (..)
import Json.Decode as Json

-- https://stackoverflow.com/questions/40113213/how-to-handle-enter-key-press-in-input-field
onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
  on "keydown" (Json.map tagger keyCode)

sendingBlock : User -> Html Msg
sendingBlock user =
    div [ class "sendingBlock" ]
        [ textarea [ onKeyDown (PendingTextKeyDown user)
                   , onInput (PendingTextChanged user)
                   , value user.pendingText ]
                   []
        , button [ onClick (SendPending user) ] [ text "OK" ]
        ]