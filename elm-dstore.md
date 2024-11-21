# elm-dstore

Distributed store pattern built using ORDT and libp2p as an elm-platforms capability.

The following design comes from this [blog post](http://archagon.net/blog/2018/03/24/data-laced-with-history/).
This architecture is thought to work on top of a p2p protocol like [socket runtime](https://socketsupply.co).

```elm
type alias AtomUid =
    { logicalTime : LogicalTime
    , site : Uuid Site
    }

{-| increase by one for every Atom emitted by the Site -}
type LogicalTime
    = LogicalTime Int

type alias Site =
    -- { auth : PubKey Identity -- public key of the identity that made the modif
    -- , copy : Uuid Copy
    -- }
    Uuid

{-| Atomic change to the data structure. Immutable and has a globally unique id (AtomUid). -}
type alias Atom op =
    { cause : AtomUid -- atom onto which this operation builds upon
    , operation : op
    }

{-| Operational Replicated Data Type
combines both Weave and Yarn to get their mutual strengths but takes twice as much memory
-}
type alias Ordt op =
    { site : Site
    , now : LogicalTime
    -- Weave : retrieve data in O(n) but retrieve specific Atom in O(n)
    , root : AtomUid
    , causalTree : Dict AtomUid (Dict AtomUid op)
    -- Yarn : retrieve specific Atom in O(1) but data in O(n^2)
    , atoms : Dict Site (Dict LogicalTime (Atom op))
    }

-- Yarn, Weave and ORDT are equivalent ways of organizing the same data
-- weaveToYarn : Weave op -> Yarn op
-- yarnToWeave : Yarn op -> Weave op
-- weaveToORDT, yarnToORDT, ...

{-| unique version vector -}
type Weft
    = Weft (Dict Site LogicalTime)
```

Attempt at synchronization:

```elm
type alias Sync op =
    { accessControl : AccessControl
    -- identity of edits
    , identity : Identity
    -- chanel through which to share the data
    , chanel : Chanel
    , data : Ordt op
    }

type SyncOp op
    = Update (List op)
    | GiveReadAccess User
    | GiveWriteAccess User
    | GiveAdminAccess User
    | RevokeReadAccess User
    | RevokeWriteAccess User
    | RevokeAdminAccess User

type alias AccessControl =
    { admins : NeList User (Maybe Signature)
    , writers : Dict User (Maybe Signature)
    , revokedWriters : Set User
    , readers : Set User
    }

{-| Reference to the p2p chanel dedicated to sharing packets acting on this data  -}
type Chanel
    = Chanel String

makePacket : Set (AtomUid, Atom (SyncOp data)) -> Packet data
send : Chanel -> Packet data -> Cmd msg
subscribe : Chanel -> Sub (SyncOp data)
```

```elm
module Ordt.Weave exposing (..)

string : Ordt StringOp -> String
list : (Ordt subOp -> data) -> Ordt (ListOp subOp) -> List data
lww : Ordt (LwwOp data) -> data
number : Ordt (NumberOp number) -> number
dict : (Ordt subOp -> data) -> Ordt (DictOp key subOp) -> Dict key data

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

type NumberOp number
    = Add number
    | Push number

type LwwOp a
    = Push a


weaveData : Ordt DataOp -> Data

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


weaveStringInput : Ordt StringInputOp -> StringInput

type alias StringInput =
    { cursors : Dict Site Selection
    , string : String
    }

type alias Selection =
    { anchor : Int, focus : Int }

type StringInputOp
    = Cursors (DictOp Site (LwwOp Selection))
    | String StringOp

weaveOrdt : (OrdtOp subOp -> data) -> Ordt (OrdtOp subOp) -> data

type OrdtOp op
    = Add AtomUid (Atom op)
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
