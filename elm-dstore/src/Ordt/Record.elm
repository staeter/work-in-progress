module Ordt.Record exposing (..)

import Random exposing (Generator)
import Ordt exposing (..)
import GDict
import LogicalTime exposing (LogicalTime)
import Ordt.Log exposing (DLog)


type Op opRecord
    = OpOnField String opRecord

type DRecord op =
    DLog (AtomUid, Maybe op)

type alias FieldSetup opField field opRecord record =
    { unwrap : opRecord -> Maybe (AtomUid, opField)
    , weave : Ordt opField -> field
    , set : field -> record -> record
    }

{-| Weave the record from its Ordt.

```elm
type alias ABC =
    { a : String
    , b : Int
    , c : List Int
    }

{-| we use the `D` convention for the Ordt version of our datatype
-}
type alias DABC =
    DRecord OpRecord

type OpRecord
    = A Ordt.String.Op
    | B Ordt.Int.Op
    | C (Ordt.List.Op Ordt.Int.Op)

weaveABC : DABC -> ABC
weaveABC ordt =
    { a = "", b = 0, c = [] }
    |> weave3Fields
        { unwrap : \opRecord->
            case opRecord of
                A opField -> Just opField
                _ -> Nothing
        , weave = Ordt.String.weave
        , set = \field record -> { record | a = field }
        }
        { unwrap : \opRecord->
            case opRecord of
                B opField -> Just opField
                _ -> Nothing
        , weave = Ordt.Int.weave
        , set = \field record -> { record | b = field }
        }
        { unwrap : \opRecord->
            case opRecord of
                C opField -> Just opField
                _ -> Nothing
        , weave = Ordt.List.weave Ordt.Int.weave
        , set = \field record -> { record | c = field }
        }
        ordt
```
-}
weave1Field :
    FieldSetup opField field opRecord record
    -> Ordt opRecord
    -> record
    -> record
weave1Field fieldSetup (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave1Field"

weave2Fields :
    FieldSetup opFieldA fieldA opRecord record
    -> FieldSetup opFieldB fieldB opRecord record
    -> Ordt opRecord
    -> record
    -> record
weave2Fields fieldSetupA fieldSetupB (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave2Fields"

weave3Fields :
    FieldSetup opFieldA fieldA opRecord record
    -> FieldSetup opFieldB fieldB opRecord record
    -> FieldSetup opFieldC fieldC opRecord record
    -> Ordt opRecord
    -> record
    -> record
weave3Fields fieldSetupA fieldSetupB fieldSetupC (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave3Fields"

weave4Fields :
    FieldSetup opFieldA fieldA opRecord record
    -> FieldSetup opFieldB fieldB opRecord record
    -> FieldSetup opFieldC fieldC opRecord record
    -> FieldSetup opFieldD fieldD opRecord record
    -> Ordt opRecord
    -> record
    -> record
weave4Fields fieldSetupA fieldSetupB fieldSetupC fieldSetupD (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave4Fields"

weave5Fields :
    FieldSetup opFieldA fieldA opRecord record
    -> FieldSetup opFieldB fieldB opRecord record
    -> FieldSetup opFieldC fieldC opRecord record
    -> FieldSetup opFieldD fieldD opRecord record
    -> FieldSetup opFieldE fieldE opRecord record
    -> Ordt opRecord
    -> record
    -> record
weave5Fields fieldSetupA fieldSetupB fieldSetupC fieldSetupD fieldSetupE (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave5Fields"
