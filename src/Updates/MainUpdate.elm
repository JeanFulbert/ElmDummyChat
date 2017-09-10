module Updates.MainUpdate exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Updates.UserSetters exposing (..)
import Updates.UserUpdaters exposing (..)
import Task
import Dom.Scroll as Scroll

sendPending : User -> Model -> ( Model, Cmd Msg )
sendPending sender model =
    let newModel =
            model
            |> updateUserInModel (setPendingText "") sender
            |> updateAllUsersInModel (setAppendedMessages sender)
        
        scrollAllHistoriesToBottom =
            newModel.users
            |> List.map (\u -> Scroll.toBottom u.chatBoxId)
            |> Task.sequence
            |> Task.attempt (always NoMessage)
    in
        ( newModel
        , scrollAllHistoriesToBottom)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoMessage ->
            (model, Cmd.none)
            
        PendingTextChanged sender text ->
            let newModel = 
                model
                |> updateUserInModel (setPendingText text) sender
            in (newModel, Cmd.none)

        SendPending sender ->
            model
            |> sendPending sender
