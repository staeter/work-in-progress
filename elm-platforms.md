# **elm-platforms**

**elm-platforms** is a standardized interface for running elm code on various platforms with different capabilities. It aims to simplify the portability of code between different platforms and ease the storage and passing of cashed data in the model and through the codebase.

## **Platforms Capabilities**

Platform capabilities group together commands, subscriptions and the caching of external data. Here are some examples of possible capabilities:

- Time capability which would provide a subscription to time updates, a command for delaying messages and would cache the current posix time.
- File system capability which would provide a subscription to file changes, a command to request dirs and files reads and writes and would cache the file system tree as well as the content of files that have been read. This second example would not be available in the Browser or in Lamdera but might be on Node, Deno or Tauri.
- View capability that provides a bunch of subscriptions mostly linked to user inputs and would cache the environment values like screen size or light/dark mode. It would be available on Browser, Lamdera frontend and Tauri while be missing on Node and Deno.
- Terminal capability which could provide stdin, stdout, stderr but also input prompts, access to Env values or running bash commands.
- Url capability for tracking the Url bar.
- HTTP capability.
- Libp2p capability for peer to peer communication through the libp2p protocol.
- etc.

Each capability is presented to the user as records containing the functions returning the commands and subscriptions that it handles as well as its cashed data.
To build an **elm-platforms** program, the user has to provide the usual record containing `init`, `update`, `subscribe` and maybe `view`. The only difference with `Browser.document` or `Platform.worker` being that each of these functions will take the platform's capabilities as their first parameter.
A partial record containing the needed capabilities can be taken as parameter by any function so that it can run on any platform handling those capabilities.

## **Platforms Implementations**

Finally users can write **elm-platforms** program implementations by providing the various non-Elm files that will wrap and build the **elm-platforms** program into an app running on any given support.

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
      { delay : Float -> msg -> cmd }
  }
```

```elm
module Platforms.Time.Internals exposing (..)

import Time

type alias Capable capabilities sub cmd msg =
  { capabilities | time : Capability sub cmd msg }

type Sub msg
  = Every Float (Time.Posix -> msg)

type Cmd msg
  = Delay Float msg

type alias Cache =
  { current : Time.Posix
  , zone : Time.Zone
  }

type alias Flags =
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

type alias Flags =
  Record Time.Flags Fs.Flags Terminal.Flags

type alias Model model =
  { model : model
  , cache : Record Time.Cache Fs.Cache Terminal.Cache
  }

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
