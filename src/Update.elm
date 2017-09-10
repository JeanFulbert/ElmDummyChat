module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Keys
import Task
import Dom.Scroll as Scroll

updateUser : (User -> User) -> User -> List User -> List User
updateUser modifyUser user users =
    users
    |> List.map (\u -> 
        if u == user
        then modifyUser u
        else u)

setPendingText : String -> User -> User
setPendingText newText user =
    { user | pendingText = newText }

updateUserInModel : (User -> User) -> User -> Model -> Model
updateUserInModel modifyUser user model =
    let newUsers =
        model.users
        |> updateUser modifyUser user
    in
        { model | users = newUsers }

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

        PendingTextChanged user text ->
            let newModel = 
                model
                |> updateUserInModel (setPendingText text) user
            in (newModel, Cmd.none)

        SendPending user ->
            let
                buildNewMessage u =
                    let source =
                            if u == user
                            then Self
                            else Other
                    in Message user.pendingText source
                
                appendNewMessage u =
                    u.messages ++ [(buildNewMessage u)]

                newUsers =
                    model.users
                    |> List.map (\u -> { u | pendingText = "", messages = appendNewMessage u })
                
                newModel = { model | users = newUsers }
            in
                ( newModel
                , newModel.users
                  |> List.map (\u -> Scroll.toBottom u.chatBoxId)
                  |> Task.sequence
                  |> Task.attempt (always NoMessage)
                )
