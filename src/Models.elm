module Models exposing (
    MessageSource(..), Message, User, Model,
    initializeModel)

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
    }


createInitialUser : Int -> String -> User
createInitialUser id name =
    let chatBoxId = "history" ++ (id |> toString)
    in  User chatBoxId name "" []

initializeModel : List String -> Model
initializeModel userNames =
    let users =
            userNames
            |> List.indexedMap createInitialUser
    in  Model users