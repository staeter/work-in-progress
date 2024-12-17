# **elm-platforms**

**elm-platforms** is a standardized interface for running Elm code on any platforms with different capabilities. It is a layer on top of elm runtime replacing `Cmd`, `Sub` and `Program`.

It aims to simplify the portability of code between different platforms and ease the storage and passing of cashed data in the model and through the codebase.

It also is a CLI that handles platforms and capabilities install, setup, build and live reload.

## **Platforms Capabilities**

Platform capabilities group together commands, subscriptions and the caching of external data. Here are some examples of possible capabilities:

- Time capability provides a subscription to time updates, a command for delaying messages and caches the current posix time.
- File system capability provides a subscription to file changes, a command to request dirs and files reads and writes and caches the file system tree as well as the content of files that have been read. This capability won't be available on the Browser nor in Lamdera's implementations of **elm-platforms** but might be on Node, Deno or Tauri implementations.
- View capability that provides a bunch of subscriptions mostly linked to user inputs and caches the environment values like screen size or light/dark mode. It could be available on Browser, Lamdera frontend and Tauri implementations while the Node and Deno ones won't be able to.
- Terminal capability which provides stdin, stdout, stderr but also input prompts, access to Env values or running bash commands.
- Url capability for tracking the Url bar only available in Browser implementation.
- HTTP capability.
- Libp2p capability for peer to peer communication with the libp2p protocol.
- Email capability to send, receive and cache emails.
- etc.

Each capability is presented to the user as records containing the functions returning the commands and subscriptions that it handles as well as its cashed data.
To build an **elm-platforms** program, the user has to write a `main` of type `Platforms.Application` or `Platforms.Program`. The only difference with using `Browser.document` or `Platform.worker` being that the `init`, `update`, `subscriptions` and eventual `view` functions take the platform's capabilities as their first parameter.
A partial record containing the needed capabilities can be taken as parameter by any function so that it can run on any platform having those capabilities.

## **Platforms Implementations**

Finally users can write **elm-platforms** program implementations by providing the various files that will wrap and build the **elm-platforms** program into an app running on the support the implementation has been made for.
It will be able to integrate different capability implementations separately and will keep track of the installed ones in the `elm-platforms.json`.
The **elm-platforms** CLI will make the installation of a platform's implementation as well as the capabilities the user wants to integrate seamless and uniform between platforms.
Provide a live reload feature that will reboot the program when their code is modified.

## **Code Samples**

We can find the types central to **elm-platforms** in `Platforms.elm`:

```elm
module Platforms exposing (..)

import Browser exposing (Document)

type alias Application capabilities sub cmd model msg =
  { init : capabilities -> ( model, cmd )
  , view : capabilities -> model -> Document msg
  , update : capabilities -> msg -> model -> ( model, cmd )
  , subscriptions : capabilities -> model -> sub
  }

type alias Program capabilities sub cmd model msg =
  { init : capabilities -> ( model, cmd )
  , update : capabilities -> msg -> model -> ( model, cmd )
  , subscriptions : capabilities -> model -> sub
  }
```

Here is an simple capability example:

```elm
module Platforms.Time exposing (..)

import Time

type alias Capability sub cmd msg =
  { cache :
      { current : Time.Posix
      , zone : Time.Zone
      }
  , sub :
      { every : Float -> (Time.Posix -> msg) -> sub }
  , cmd :
      { delay : Float -> msg -> cmd
      , at : Time.Posix -> msg -> cmd
      }
  }

type alias Capable capabilities sub cmd msg =
  { capabilities | time : Capability sub cmd msg }
```

```elm
module Platforms.Time.Internals exposing (..)

import Time

type Sub msg
  = Every Float (Time.Posix -> msg)

type Cmd msg
  = Delay Float msg
  | At Time.Posix msg

type alias Cache =
  { current : Time.Posix
  , zone : Time.Zone
  }
```

And here is an API example of an **elm-platforms** implementation:

```elm
module Platforms.Deno exposing (..)

import Platforms.Deno.Internals exposing (..)

{-| type to be returned by main -}
type alias Program model msg =
  Platforms.Program (Capabilities msg) (Sub msg) (Cmd msg) model msg
```

```elm
module Platforms.Deno.Internals exposing (..)

import Platforms.Time.Internals as Time
import Platforms.Fs.Internals as Fs
import Platforms.Terminal.Internals as Terminal

type alias Capabilities msg =
  Record
    (Time.Capability (Sub msg) (Cmd msg) msg)
    (Fs.Capability (Sub msg) (Cmd msg) msg)
    (Terminal.Capability (Sub msg) (Cmd msg) msg)

type alias Cmd msg =
  Union (Time.Cmd msg) (Fs.Cmd msg) (Terminal.Cmd msg)

type alias Sub msg =
  Union (Time.Sub msg) (Fs.Sub msg) (Terminal.Sub msg)

type alias Model model =
  { model : model
  , cache : Record Time.Cache Fs.Cache Terminal.Cache
  }

---- UTILS ----

type alias Record time fs term =
  { time : time
  , fileSystem : fs
  , terminal : term
  }

type Union time fs term
  = Time time
  | FileSystem fs
  | Terminal term
```

The setup of platforms and their capabilities is handled by **elm-platforms** CLI which keeps track of everything in the `elm-platforms.json` file.

```json
{
  "elm-platforms-version": "1.0.0",
  "type": "programs", // could also be platform or capability
  "programs": [
    { "main": "src/Cli.elm"
    , "platform": {
        "staeter/elm-platforms-deno": "1.1.0" // loaded from github in the same way that Elm packages are
      }
    , "capabilities": {
        "direct": {
          "staeter/elm-platforms-deno-time": "1.0.0",
          "staeter/elm-platforms-deno-fileSystem": "3.0.0",
          "staeter/elm-platforms-deno-terminal": "1.0.2"
        },
        "indirect": {}
      }
    , "build": "build/cli/"
    }
  , { "main": "src/Web.elm"
    , "platform": {
        "staeter/elm-platforms-browser": "1.3.0"
      }
    , "capabilities": {
        "direct": {
          "staeter/elm-platforms-deno-time": "1.0.0",
          "staeter/elm-platforms-deno-view": "1.0.0"
        },
        "indirect": {}
      }
    , "build": "build/web/"
    }
  ]
}
```
