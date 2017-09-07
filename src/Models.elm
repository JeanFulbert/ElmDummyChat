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
    , messages: List Message
    }

type alias Model = List User
