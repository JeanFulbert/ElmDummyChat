module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PendingTextChanged user text ->
            let newModel =
                    model
                    |> List.map (\u -> 
                        if u == user
                        then { u | pendingText = text }
                        else u)
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
                    (buildNewMessage u)::u.messages
                    |> List.reverse

                newModel =
                    model
                    |> List.map (\u -> { u | pendingText = "", messages = appendNewMessage u })
            in
                (newModel, Cmd.none)
