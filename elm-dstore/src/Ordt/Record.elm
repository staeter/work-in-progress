module Ordt.Record exposing (..)

import Ordt exposing (..)
import GDict
import Ordt.Log exposing (DLog)


type Op op
    = OpOnField String op

{-| A record ordt -}
type alias DRecord op =
    Ordt (Op op)

{-| Setup describing how to interact with every field.
-}
type alias FieldSetup opField field opRecord record =
    { wrap : opField -> opRecord
    , unwrap : opRecord -> Maybe (Atom opField)
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

fieldA : FieldSetup Ordt.String.Op String OpRecord ABC
fieldA =
    { wrap : A
    , unwrap : \opRecord->
        case opRecord of
            A opField -> Just opField
            _ -> Nothing
    , weave = Ordt.String.weave
    , set = \field record -> { record | a = field }
    }

fieldB : FieldSetup Ordt.Int.Op Int OpRecord ABC
fieldB =
    { wrap : B
    , unwrap : \opRecord->
        case opRecord of
            B opField -> Just opField
            _ -> Nothing
    , weave = Ordt.Int.weave
    , set = \field record -> { record | b = field }
    }

fieldC : FieldSetup (Ordt.List.Op Ordt.Int.Op) (List Int) OpRecord ABC
fieldC =
    { wrap : c
    , unwrap : \opRecord->
        case opRecord of
            C opField -> Just opField
            _ -> Nothing
    , weave = Ordt.List.weave Ordt.Int.weave
    , set = \field record -> { record | c = field }
    }

weaveABC : DABC -> ABC
weaveABC ordt =
    { a = "", b = 0, c = [] }
    |> weave3Fields fieldA fieldB fieldC ordt
```
-}
weave1Field :
    FieldSetup opField field op record
    -> DRecord op
    -> record
    -> record
weave1Field fieldSetup (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave1Field"

weave2Fields :
    FieldSetup opFieldA fieldA op record
    -> FieldSetup opFieldB fieldB op record
    -> DRecord op
    -> record
    -> record
weave2Fields fieldSetupA fieldSetupB (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave2Fields"

weave3Fields :
    FieldSetup opFieldA fieldA op record
    -> FieldSetup opFieldB fieldB op record
    -> FieldSetup opFieldC fieldC op record
    -> DRecord op
    -> record
    -> record
weave3Fields fieldSetupA fieldSetupB fieldSetupC (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave3Fields"

weave4Fields :
    FieldSetup opFieldA fieldA op record
    -> FieldSetup opFieldB fieldB op record
    -> FieldSetup opFieldC fieldC op record
    -> FieldSetup opFieldD fieldD op record
    -> DRecord op
    -> record
    -> record
weave4Fields fieldSetupA fieldSetupB fieldSetupC fieldSetupD (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave4Fields"

weave5Fields :
    FieldSetup opFieldA fieldA op record
    -> FieldSetup opFieldB fieldB op record
    -> FieldSetup opFieldC fieldC op record
    -> FieldSetup opFieldD fieldD op record
    -> FieldSetup opFieldE fieldE op record
    -> DRecord op
    -> record
    -> record
weave5Fields fieldSetupA fieldSetupB fieldSetupC fieldSetupD fieldSetupE (Ordt ordt) recordToBeFilled =
    Debug.todo "Ordt.Record.weave5Fields"


{-| Get the ORDT of a given field. -}
getField : FieldSetup opField field op record -> DRecord op -> Ordt opField
getField fieldSetup (Ordt ordt) =
    Debug.todo "Ordt.Record.getField"

updateField : FieldSetup opField field op record -> Ordt opField -> DRecord op -> DRecord op
updateField fieldSetup updatedField (Ordt ordt) =
    Debug.todo "Ordt.Record.updateField"
