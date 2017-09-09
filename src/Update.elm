module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Keys
import Task
import Dom.Scroll exposing (..)

enterKey : Int
enterKey = 13

updateUser : (User -> User) -> User -> List User -> List User
updateUser modifyUser user users =
    users
    |> List.map (\u -> 
        if u == user
        then modifyUser u
        else u)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoMessage -> model ! []

        ShiftKeyDown isDown ->
            ({ model | isShiftDown = isDown }, Cmd.none)

        PendingTextKeyDown user key ->
            if key == Keys.enter && model.isShiftDown
            then update (SendPending user) model
            else (model, Cmd.none)

        PendingTextChanged user text ->
            let newUsers =
                    updateUser
                        (\u -> { u | pendingText = text })
                        user
                        model.users
                newModel = { model | users = newUsers }
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
                (newModel, Cmd.none)
                -- , Task.attempt (always NoMessage) <| toBottom "history")
