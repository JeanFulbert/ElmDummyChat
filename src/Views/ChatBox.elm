module Views.ChatBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg(..))
import Models exposing (..)
import Views.SendingBlock exposing (..)
import Views.MessageBox exposing (..)

chatBox : User -> Html Msg
chatBox user =
    section [ class "chat"]
            [ h2 [] [ text user.name ]
            , ol [ id user.chatBoxId, class "history" ] 
                 ( user.messages |> List.map messageBox)
            , sendingBlock user
            ]