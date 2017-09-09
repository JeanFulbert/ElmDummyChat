module Views.ChatBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (Msg(..))
import Models exposing (..)
import Json.Decode as Json
import Regex exposing (..)

-- https://stackoverflow.com/questions/40113213/how-to-handle-enter-key-press-in-input-field
onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
  on "keydown" (Json.map tagger keyCode)

escapeString : String -> List (Html msg)
escapeString s =
    s
    |> split All (regex "\n")
    |> List.map text
    |> List.intersperse (br [] [])

messageBox : Message -> Html Msg
messageBox message =
    let spanClass =
        case message.source of
            Self -> "left"
            Other -> "right"
    in  li  []
            [ span [ class spanClass ] 
                   ( message.content |> escapeString )
            ]

sendingBlock : User -> Html Msg
sendingBlock user =
    div [ class "sendingBlock" ]
        [ textarea [ onKeyDown (PendingTextKeyDown user)
                   , onInput (PendingTextChanged user)
                   , value user.pendingText ]
                   []
        , button [ onClick (SendPending user) ] [ text "OK" ]
        ]

chatBox : User -> Html Msg
chatBox user =
    section [ class "chat"]
            [ h2 [] [ text user.name ]
            , ol [ class "history" ] 
                 ( user.messages
                   |> List.map messageBox
                 )
            , sendingBlock user
            ]