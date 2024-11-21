# elm-dstore

Distributed store pattern built using ORDT and libp2p as an elm-platforms capability.

The following design comes from this [blog post](http://archagon.net/blog/2018/03/24/data-laced-with-history/).

```elm
type alias AtomUid =
    { lamportTimestamp : LamportTimestamp
    , site : Site
    }

{-| The site the data is stored and edited from. It contains the identity's pubKey as well as a short uid of its device. The same device has a different uid for each identity it hosts.
-}
type Site
    = Site ...

{-| Atomic change to the data structure. Immutable and has a globally unique id (AtomUid). -}
type alias Atom op =
    { cause : AtomUid -- atom onto which this operation builds upon
    , operation : op
    }

type alias StructureLog op =
    { weave : Weave op
    , here : Site
    , highestLamportTimestamp : LamportTimestamp
    }

type alias Weave op =
    { root : AtomUid
    , causalTree : Dict AtomUid (Dict AtomUid op)
    }

type LamportTimestamp
    = LamportTimestamp Int

toYarn : Weave op -> Dict Site (Dict LamportTimestamp (Atom op))

type WeaveOp op
    = Root AtomUid
    | CausalTree (DictOp AtomUid (DictOp AtomUid op))
```

Attempt at synchronization:

```elm
type alias Sync data =
    { accessControl : AccessControl
    , identity : Identity
    , feed : Feed
    , data : data
    }

type SyncOp data = ...

type alias AccessControl =
    { admin : NeDict User (Maybe Signature)
    , writer : Dict User (Maybe Signature)
    , reader : Set User
    }

type Feed
    = Feed String

makePacket : Set (AtomUid, Atom (SyncOp data)) -> Packet data
send : Feed -> Packet data -> Cmd msg
subscribe : Feed -> Sub (SyncOp data)
```

```elm
weaveString : Weave StringOp -> String
weaveList : (Weave subOp -> data) -> Weave (ListOp subOp) -> List data
weaveLww : Weave (LwwOp data) -> data
weaveAddOnly : Weave (AddOnlyOp number) -> number
weaveDict : (Weave subOp -> data) -> Weave (DictOp key subOp) -> Dict key data

type StringOp
    = Insert Char
    | Tombstone

type ListOp subOp
    = Insert subOp
    | Update subOp
    | Tombstone

type DictOp key subOp
    = Insert key subOp
    | Update key subOp
    | Tombstone key

type AddOnlyOp number
    = Add number

type LwwOp a
    = Push a


weaveData : Weave DataOp -> Data

type alias Data =
    { stringField : String
    , appendIntField : Int
    , lwwIntField : Int
    , floatListField : List Float
    }

type DataOp
    = StringField StringOp
    | AppendIntField (AddOnlyOp Int)
    | LwwIntField (LwwOp Int)
    | FloatListField (ListOp Float)


weaveStringInput : Weave StringInputOp -> StringInput

type alias StringInput =
    { cursors : Dict Site Selection
    , string : String
    }

type alias Selection =
    { anchor : Int, focus : Int }

type StringInputOp
    = Cursors (DictOp Site (LwwOp Selection))
    | String StringOp
```

Previous attempts:

```elm
type alias Event op =
    { key : EventKey
    , operation : op
    , signature : SignedHash -- hash of EventKey ++ operation
    }

type alias CRDTSetup op data =
    { apply : EventKey -> op -> data -> Maybe data -- return Nothing if invalid op
    , opCodec : Codec op
    , signAs : Identity
    }

type Identity
    = Identity PubKey PrivKey

type alias ORDT op data =
    { eventLog : List (Event op)
    , current : data
    , identity : Id Identity
    , accessControl : Id AccessControl
    }

type alias Effect op data =
    List
        { crdt : Id (ORDT op data)
        , event : Event op
        , accessControl : Id AccessControl
        , identity : Id Identity
        }

type alias AccessControl =
    { eventLog : List (Event AccessUpdate)
    , admin : NeList (User, Maybe Signature)
    , writer : List (User, Maybe Signature)
    , reader : List (User, Maybe Signature)
    }


{-| hash of the user's last event combined with the hash  -}
type Signature =
    Signature String
```

```elm
type alias StringCRDT =
    ORDT StringOp
      { content : List (EventKey, TombstoneChar)
      , reversions : List Revert
      }

type alias StringOp =
    { insert : TombstoneChar, behindOf : EventKey }

type TombstoneChar
    = Char Char
    | TombstonePreceding

type Revert
    = Backward
    | Forward

get : User -> StringCRDT -> Maybe String
update : User -> String -> StringCRDT -> StringCRDT
revert : User -> Revert -> StringCRDT -> StringCRDT
```

```elm
type alias Field record recordOp fieldOp field =
    { get : record -> ORDT fieldOp field
    , set : ORDT fieldOp field -> record -> record
    , toRecordOp : fieldOp -> recordOp
    , fromRecordOp : recordOp -> Maybe fieldOp
    }
```

```elm
-- this would be very easy do code with but would be terrible performance
-- you'd need to traverse the whole model on every update
-- also I'd have a hard time making changes to AccessControl
type alias StoreSetup =
    { setData : model -> ORDT op data -> ORDT op data
    , setModel : ORDT op data -> model -> model
    }
```
