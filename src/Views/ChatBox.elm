module Views.ChatBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (..)

messageBox : Message -> Html Msg
messageBox message =
    let spanClass =
        case message.source of
            Self -> "left"
            Other -> "right"
    in  li  []
            [ span [ class spanClass ] 
                   [ text message.content ]
            ]

sendingBlock : User -> Html Msg
sendingBlock user =
    div [ class "sendingBlock" ]
        [ textarea [] []
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