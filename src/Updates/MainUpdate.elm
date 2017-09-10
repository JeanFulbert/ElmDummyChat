module Updates.MainUpdate exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Updates.UserSetters exposing (..)
import Updates.UserUpdaters exposing (..)
import Keys
import Task
import Dom.Scroll as Scroll

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoMessage ->
            (model, Cmd.none)

        ShiftKeyDown isDown ->
            ({ model | isShiftDown = isDown }, Cmd.none)

        PendingTextKeyDown user key ->
            if key == Keys.enter && not model.isShiftDown
            then update (SendPending user) model
            else (model, Cmd.none)

        PendingTextChanged sender text ->
            let newModel = 
                model
                |> updateUserInModel (setPendingText text) sender
            in (newModel, Cmd.none)

        SendPending sender ->
            let
                newModel =
                    model
                    |> updateUserInModel (setPendingText "") sender
                    |> updateAllUsersInModel (setAppendedMessages sender)
            in
                ( newModel
                , newModel.users
                  |> List.map (\u -> Scroll.toBottom u.chatBoxId)
                  |> Task.sequence
                  |> Task.attempt (always NoMessage)
                )
