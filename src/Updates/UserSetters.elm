module Updates.UserSetters exposing (setPendingText, setAppendedMessages)

import Models exposing (..)

buildNewMessage : User -> User -> Message
buildNewMessage sender user =
    let
        source =
            if user.name == sender.name
            then Self
            else Other
    in
        Message sender.pendingText source

setPendingText : String -> User -> User
setPendingText newText user =
    { user | pendingText = newText }

setMessages : List Message -> User -> User
setMessages newMessages user =
    { user | messages = newMessages }

setAppendedMessages : User -> User -> User
setAppendedMessages sender user =
    let newMessages = user.messages ++ [(buildNewMessage sender user)]
    in  setMessages newMessages user