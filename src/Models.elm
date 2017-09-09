module Models exposing (..)

type MessageSource
    = Self
    | Other

type alias Message =
    { content: String
    , source: MessageSource
    }
    
type alias User =
    { name: String
    , pendingText: String
    , messages: List Message
    }

type alias Model = List User
