module Updates.UserUpdaters exposing (..)

import Models exposing (..)

updateUser : (User -> User) -> (User -> Bool) -> List User -> List User
updateUser modifyUser canModify users =
    users
    |> List.map (\u -> 
        if canModify u
        then modifyUser u
        else u)

applyUpdateUserToModel : (User -> User) -> (User -> Bool) -> Model -> Model
applyUpdateUserToModel modifyUser canModify model =
    let newUsers =
        model.users
        |> updateUser modifyUser canModify
    in
        { model | users = newUsers }

updateUserInModel : (User -> User) -> User -> Model -> Model
updateUserInModel modifyUser user model =
    model
    |> applyUpdateUserToModel modifyUser (\u -> u == user)

updateAllUsersInModel : (User -> User) -> Model -> Model
updateAllUsersInModel modifyUser model =
    model
    |> applyUpdateUserToModel modifyUser (\u -> True)