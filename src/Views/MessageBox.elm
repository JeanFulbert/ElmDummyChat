module Views.MessageBox exposing (messageBox)

import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg(..))
import Models exposing (..)
import Regex exposing (..)

escapeString : String -> List (Html msg)
escapeString s =
    s
    |> split All (regex "\n")
    |> List.map text
    |> List.intersperse (br [] [])

spanClass : MessageSource -> String
spanClass source =
    case source of
        Self -> "left"
        Other -> "right"

messageBox : Message -> Html Msg
messageBox message =
    li  []
        [ span [ class (message.source |> spanClass) ] 
               ( message.content |> escapeString )
        ]