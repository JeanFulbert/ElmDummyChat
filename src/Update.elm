module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PendingTextChanged text user -> (model, Cmd.none)
        SendPending user ->
            let
                buildNewMessage u =
                    let source =
                        if u == user
                        then Self
                        else Other
                    in Message "toto" source
                
                buildNewMessages u =
                    (buildNewMessage u)::u.messages
                    |> List.reverse

                newModel =
                    model
                    |> List.map (\u -> { u | messages = buildNewMessages u })
            in
                (newModel, Cmd.none)
