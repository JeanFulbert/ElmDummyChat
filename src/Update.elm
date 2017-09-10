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

setMessages : List Message -> User -> User
setMessages newMessages user =
    { user | messages = newMessages }

updateUserInModel : (User -> User) -> User -> Model -> Model
updateUserInModel modifyUser user model =
    let newUsers =
        model.users
        |> updateUser modifyUser user
    in
        { model | users = newUsers }

updateAllUsersInModel : (User -> User) -> Model -> Model
updateAllUsersInModel modifyUser model =
    let newUsers =
        model.users
        |> List.map modifyUser
    in
        { model | users = newUsers }

buildNewMessage : User -> User -> Message
buildNewMessage user sender =
    let
        source =
            if user == sender
            then Self
            else Other
    in
        Message sender.pendingText source
        
appendNewMessage : User -> User -> List Message           
appendNewMessage user sender =
    user.messages ++ [(buildNewMessage user sender)]

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

        SendPending sender ->
            let
                newUsers =
                    model.users
                    |> List.map (\u -> { u
                        | pendingText = ""
                        , messages = appendNewMessage u sender })
                
                newModel = { model | users = newUsers }

                newModel2 =
                    model
                    |> updateUserInModel (setPendingText "") sender
                    |> updateAllUsersInModel (\u -> 
                        setMessages (appendNewMessage u sender) u)
            in
                ( newModel
                , newModel.users
                  |> List.map (\u -> Scroll.toBottom u.chatBoxId)
                  |> Task.sequence
                  |> Task.attempt (always NoMessage)
                )
