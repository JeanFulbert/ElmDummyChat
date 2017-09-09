module Views.MainView exposing (..)

import Html exposing (Html, div, text, button)
import Html.Attributes exposing (class)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Views.ChatBox exposing (..)

view : Model -> Html Msg
view model =
    div [ class "main" ]
        ( model.users |> List.map chatBox)