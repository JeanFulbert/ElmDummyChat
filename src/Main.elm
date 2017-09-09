module Main exposing (..)

import Html exposing (program)
import Messages exposing (Msg)
import Models exposing (..)
import Update exposing (update)
import Views.MainView exposing (view)

users : List String
users = [ "Alice", "Bob" ]

createInitialUser : String -> User
createInitialUser name =
    User name "" []

init : ( Model, Cmd Msg )
init = ( users |> List.map createInitialUser
       , Cmd.none )

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \m -> Sub.none
        }