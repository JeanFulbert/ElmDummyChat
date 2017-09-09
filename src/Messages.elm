module Messages exposing (..)

import Models exposing (..)

type Msg
    = PendingTextChanged User String
    | PendingTextKeyDown User Int
    | SendPending User
    | NoMessage