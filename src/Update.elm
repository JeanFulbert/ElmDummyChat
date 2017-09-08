module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PendingTextChanged text user -> (model, Cmd.none)
        SendPending user -> (model, Cmd.none)
