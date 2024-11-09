# elm-dstore

Distributed store pattern built using CRDT and libp2p as a elm-platforms capability.

Inspired by anysync and automerge.

```elm
type alias Event op =
    { key : EventKey
    , operation : op
    , signature : SignedHash
    }

type alias EventKey =
    { time : Posix
    , index : Int
    , author : User
    }

type alias CRDTSetup op data =
    { opToString : op -> String
    , apply : EventKey -> op -> data -> data
    , revert : EventKey -> data -> data
    , user : User
    }

map2 :
  Accessors data op data1 op1
  -> Accessors data op data2 op2
  -> CRDTSetup data op

type alias Accessors record recordOp data op =
    { getData : record -> data
    , setData : data -> record -> record
    , toOp : recordOp -> Maybe op
    , wrapOp : op -> recordOp
    , setup : CRDTSetup op data
    }

type alias CRDTStore op data =
    { queue : List (Event op)
    , accessControl : AccessControl
    }

type alias CRDT op data =
    { history : List (Event op)
    , current : data
    }

type alias AccessControl =
    { history : List (Event AccessUpdate)
    , admin : NESet User
    , write : Set User
    , read : Set User
    }
```

```elm
type alias StringCRDT =
    CRDT StringOp
      { content : List (EventKey, TombstoneChar)
      , invalid : List EventKey
      , reversions : List Revert
      }

type alias StringOp =
    { index : Int, insert : TombstoneChar }

type TombstoneChar
    = Letter Char
    | TombstoneNextLetter

type Revert
    = Backward
    | Forward

get : User -> StringCRDT -> Maybe String
update : User -> String -> StringCRDT -> StringCRDT
revert : User -> Revert -> StringCRDT -> StringCRDT
```
