module Updates.UserUpdaters exposing (..)

import Models exposing (..)

updateUser : (User -> User) -> User -> List User -> List User
updateUser modifyUser user users =
    users
    |> List.map (\u -> 
        if u == user
        then modifyUser u
        else u)

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
