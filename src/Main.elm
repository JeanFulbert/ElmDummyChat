module Main exposing (..)

import Html exposing (program)
import Messages exposing (Msg)
import Models exposing (..)
import Update exposing (update)
import Views.MainView exposing (view)
import Keyboard exposing (..)
import Char exposing (..)

userNames : List String
userNames = [ "Alice", "Bob" ]

createInitialUser : String -> User
createInitialUser name =
    User name "" []

initialModel : Model
initialModel =
    let users = userNames |> List.map createInitialUser
    in Model users False

init : ( Model, Cmd Msg )
init = ( initialModel, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }