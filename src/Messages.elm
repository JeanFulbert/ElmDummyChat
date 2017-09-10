module Messages exposing (..)

import Models exposing (..)

type Msg
    = PendingTextChanged User String
    | SendPending User
    | NoMessage