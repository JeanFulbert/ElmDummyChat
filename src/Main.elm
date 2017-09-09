module Main exposing (..)

import Html exposing (program)
import Messages exposing (..)
import Models exposing (..)
import Update exposing (update)
import Views.MainView exposing (view)
import Keys
import Keyboard exposing (..)

userNames : List String
userNames = [ "Alice", "Bob", "Chris" ]

createInitialUser : String -> User
createInitialUser name =
    User name "" []

initialModel : Model
initialModel =
    let users = userNames |> List.map createInitialUser
    in Model users False

init : ( Model, Cmd Msg )
init = ( initialModel, Cmd.none )

notifyShiftChange : Bool -> Int -> Msg
notifyShiftChange isShiftDown keyCode =
    if keyCode == Keys.shift
    then ShiftKeyDown isShiftDown
    else NoMessage

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs <| notifyShiftChange True
        , Keyboard.ups <| notifyShiftChange False
        ]

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }