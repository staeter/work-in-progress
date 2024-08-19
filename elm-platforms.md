# **elm-platforms**

**elm-platforms** is a standardized interface for running elm code on various platforms with different capabilities. It aims to simplify the portability of code between different platforms and ease the storage and passing of cashed data in the model and through the codebase.

Platform capabilities group together commands, subscriptions and the cashing of external data. Here are some examples of possible capabilities:

- Time capability which would provide a subscription to time updates, a command for delaying messages and would cash the current posix time.
- File system capability which would provide a subscription to file changes, a command to request dirs and files reads and writes and would cash the file system tree as well as the content of files that have been read. This second example would not be available in the Browser or in Lamdera but might be on Node, Deno or Tauri.
- View capability that provides a bunch of subscriptions mostly linked to user inputs and would cash the environment values like screen size or light/dark mode. It would be available on Browser, Lamdera frontend and Tauri while be missing on Node and Deno.
- Terminal capability which could provide stdin, stdout, stderr but also input prompts, access to Env values or running bash commands.
- Url capability for tracking the Url bar.
- HTTP capability.
- Libp2p capability for peer to peer communication through the libp2p protocol.
- etc.

Each capability is presented to the user as records containing the functions returning the commands and subscriptions that it handles as well as its cashed data.
To build an **elm-platforms** program, the user has to provide the usual record containing `init`, `update`, `subscribe` and maybe `view`. The only difference with `Browser.document` or `Platform.worker` being that each of these functions will take the platform's capabilities as their first parameter.
A partial record containing the needed capabilities can be taken as parameter by any function so that it can run on any platform handling those capabilities.

Finally users can write **elm-platforms** program implementations by providing the various non-Elm files that will wrap and build the **elm-platforms** program into an app running on any given support.

```elm
-- in Platforms.elm

type alias Capability cash subCalls cmdCalls =
  { cash : cash
  , sub : subCalls
  , cmd : cmdCalls
  }

type alias Application flags cap model sub cmd msg =
  { init : cap -> ( model, cmd )
  , view : cap -> model -> Document msg
  , update : cap -> msg -> model -> ( model, cmd )
  , subscriptions : cap -> model -> sub
  }
  -> Platform.Program flags model msg

type alias Program flags cap model sub cmd msg =
  { init : cap -> ( model, cmd )
  , update : cap -> msg -> model -> ( model, cmd )
  , subscriptions : cap -> model -> sub
  }
  -> Platform.Program flags model msg
```

```elm
-- in Platforms/Time.elm

type alias Capability sub cmd msg =
  { cash :
      { current : Time.Posix
      , zone : Time.Zone
      }
  , sub :
      { every : Float -> (Time.Posix -> msg) -> sub }
  , cmd :
      { delay : Float -> msg -> cmd }
  }

type alias Capable cap sub cmd msg =
  { cap | time : Capability sub cmd msg }
```

```elm
-- in Platforms/
