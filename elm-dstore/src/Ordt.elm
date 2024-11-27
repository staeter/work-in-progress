module Ordt exposing (..)

{-| Operational Replicated Data Type

This implementation comes from [this blogpost](http://archagon.net/blog/2018/03/24/data-laced-with-history/).

-}


{-| Atomic change to the data structure. Immutable and has a globally unique id (AtomUid).
-}
type alias Atom op =
    { cause : AtomUid -- atom onto which this operation builds upon
    , operation : op
    }


type alias AtomUid =
    { logicalTime : LogicalTime
    , site : Site
    }


{-| increase by one for every Atom emitted by the Site
-}
type LogicalTime
    = LogicalTime Int


type Site
    = SiteUuid String


{-| Operational Replicated Data Type
-}
type Ordt op
    = Ordt
        { site : Site
        , now : LogicalTime

        -- Weave : retrieve data in O(n) but retrieve specific Atom in O(n)
        , root : AtomUid
        , causalTree : Dict AtomUid (Dict AtomUid op)

        -- Yarn : retrieve specific Atom in O(1) but data in O(n^2)
        , atoms : Dict Site (Dict LogicalTime (Atom op))
        }


{-| unique version vector
-}
type Weft
    = Weft (Dict Site LogicalTime)
