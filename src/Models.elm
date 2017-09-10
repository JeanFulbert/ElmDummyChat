module Models exposing (..)

type MessageSource
    = Self
    | Other

type alias Message =
    { content: String
    , source: MessageSource
    }
    
type alias User =
    { chatBoxId: String
    , name: String
    , pendingText: String
    , messages: List Message
    }

type alias Model =
    { users: List User
    , isShiftDown: Bool
    }
