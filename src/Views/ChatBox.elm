module Views.ChatBox exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
-- import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (..)

chatBox : User -> Html Msg
chatBox user =
    section [ class "chat"]
            [ h2 [] [ text user.name ]
            , ol [ class "history" ] []
            , div [ class "sendingBlock" ]
                [ textarea [] []
                , button [] [ text "OK" ]
                ]
            ]