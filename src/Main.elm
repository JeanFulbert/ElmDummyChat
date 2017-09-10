module Main exposing (..)

import Html exposing (program)
import Messages exposing (..)
import Models exposing (..)
import Update exposing (update)
import Views.MainView exposing (view)
import Subscriptions exposing (..)

userNames : List String
userNames = [ "Alice", "Bob", "Chris" ]

init : ( Model, Cmd Msg )
init = ( initializeModel userNames, Cmd.none )

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }