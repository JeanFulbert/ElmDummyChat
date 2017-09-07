module Views.MainView exposing (..)

import Html exposing (Html, div, text, button)
import Html.Attributes exposing (class)
-- import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Views.ChatBox exposing (..)

view : Model -> Html Msg
view model =
    div [ class "main" ]
        ( model |> List.map chatBox)