module Messages exposing (..)

import Models exposing (..)

type Msg
    = PendingTextChanged String User
    | SendPending User