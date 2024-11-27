module DiffBy exposing
    ( Change(..)
    , diffBy
    )

{-| Compares two list and returns how they have changed.
Each function internally uses Wu's [O(NP) algorithm](http://myerslab.mpi-cbg.de/wp-content/uploads/2014/06/np_diff.pdf).

This module is an adapted version of [jinjor/elm-diff](https://package.elm-lang.org/packages/jinjor/elm-diff/1.0.6).


# Types

@docs Change


# Diffing

@docs diff, diffLines

-}

import Array exposing (Array)


{-| This describes how each line has changed and also contains its value.
-}
type Change a b
    = Added b
    | Removed a
    | NoChange a


type StepResult
    = Continue (Array (List ( Int, Int )))
    | Found (List ( Int, Int ))


type BugReport
    = CannotGetA Int
    | CannotGetB Int
    | UnexpectedPath ( Int, Int ) (List ( Int, Int ))


{-| Diff using `c` type for comparison.
-}
diffBy : (a -> c) -> (b -> c) -> List a -> List b -> List (Change a b)
diffBy aToC bToC a b =
    testDiff aToC bToC a b
        |> Result.withDefault []


{-| Test the algorithm itself.
If it returns Err, it should be a bug.
-}
testDiff : (a -> c) -> (b -> c) -> List a -> List b -> Result BugReport (List (Change a b))
testDiff aToC bToC a b =
    let
        arrA =
            Array.fromList a

        arrB =
            Array.fromList b

        m =
            Array.length arrA

        n =
            Array.length arrB

        -- Elm's Array doesn't allow null element,
        -- so we'll use shifted index to access source.
        getA =
            \x -> Array.get (x - 1) arrA

        getB =
            \y -> Array.get (y - 1) arrB

        path =
            -- Is there any case ond is needed?
            -- ond (getA >> Maybe.map aToC) (getB >> Maybe.map bToC) m n
            onp
                (getA >> Maybe.map aToC)
                (getB >> Maybe.map bToC)
                m
                n
    in
    makeChanges getA getB path


makeChanges :
    (Int -> Maybe a)
    -> (Int -> Maybe b)
    -> List ( Int, Int )
    -> Result BugReport (List (Change a b))
makeChanges getA getB path =
    case path of
        [] ->
            Ok []

        latest :: tail ->
            makeChangesHelp [] getA getB latest tail


makeChangesHelp :
    List (Change a b)
    -> (Int -> Maybe a)
    -> (Int -> Maybe b)
    -> ( Int, Int )
    -> List ( Int, Int )
    -> Result BugReport (List (Change a b))
makeChangesHelp changes getA getB ( x, y ) path =
    case path of
        [] ->
            Ok changes

        ( prevX, prevY ) :: tail ->
            let
                change =
                    if x - 1 == prevX && y - 1 == prevY then
                        case getA x of
                            Just a ->
                                Ok (NoChange a)

                            Nothing ->
                                Err (CannotGetA x)

                    else if x == prevX then
                        case getB y of
                            Just b ->
                                Ok (Added b)

                            Nothing ->
                                Err (CannotGetB y)

                    else if y == prevY then
                        case getA x of
                            Just a ->
                                Ok (Removed a)

                            Nothing ->
                                Err (CannotGetA x)

                    else
                        Err (UnexpectedPath ( x, y ) path)
            in
            case change of
                Ok c ->
                    makeChangesHelp (c :: changes) getA getB ( prevX, prevY ) tail

                Err e ->
                    Err e



-- Myers's O(ND) algorithm (http://www.xmailserver.org/diff2.pdf)


ond : (Int -> Maybe c) -> (Int -> Maybe c) -> Int -> Int -> List ( Int, Int )
ond getA getB m n =
    let
        v =
            Array.initialize (m + n + 1) (always [])
    in
    ondLoopDK (snake getA getB) m 0 0 v


ondLoopDK :
    (Int -> Int -> List ( Int, Int ) -> ( List ( Int, Int ), Bool ))
    -> Int
    -> Int
    -> Int
    -> Array (List ( Int, Int ))
    -> List ( Int, Int )
ondLoopDK snake_ offset d k v =
    if k > d then
        ondLoopDK snake_ offset (d + 1) (-d - 1) v

    else
        case step snake_ offset k v of
            Found path ->
                path

            Continue v_ ->
                ondLoopDK snake_ offset d (k + 2) v_



-- Wu's O(NP) algorithm (http://myerslab.mpi-cbg.de/wp-content/uploads/2014/06/np_diff.pdf)


onp :
    (Int -> Maybe c)
    -> (Int -> Maybe c)
    -> Int
    -> Int
    -> List ( Int, Int )
onp getA getB m n =
    let
        v =
            Array.initialize (m + n + 1) (always [])

        delta =
            n - m
    in
    onpLoopP (snake getA getB) delta m 0 v


onpLoopP :
    (Int -> Int -> List ( Int, Int ) -> ( List ( Int, Int ), Bool ))
    -> Int
    -> Int
    -> Int
    -> Array (List ( Int, Int ))
    -> List ( Int, Int )
onpLoopP snake_ delta offset p v =
    let
        ks =
            if delta > 0 then
                List.reverse (List.range (delta + 1) (delta + p))
                    ++ List.range -p delta

            else
                List.reverse (List.range (delta + 1) p)
                    ++ List.range (-p + delta) delta
    in
    case onpLoopK snake_ offset ks v of
        Found path ->
            path

        Continue v_ ->
            onpLoopP snake_ delta offset (p + 1) v_


onpLoopK :
    (Int -> Int -> List ( Int, Int ) -> ( List ( Int, Int ), Bool ))
    -> Int
    -> List Int
    -> Array (List ( Int, Int ))
    -> StepResult
onpLoopK snake_ offset ks v =
    case ks of
        [] ->
            Continue v

        k :: ks_ ->
            case step snake_ offset k v of
                Found path ->
                    Found path

                Continue v_ ->
                    onpLoopK snake_ offset ks_ v_


step :
    (Int -> Int -> List ( Int, Int ) -> ( List ( Int, Int ), Bool ))
    -> Int
    -> Int
    -> Array (List ( Int, Int ))
    -> StepResult
step snake_ offset k v =
    let
        fromLeft =
            Maybe.withDefault [] (Array.get (k - 1 + offset) v)

        fromTop =
            Maybe.withDefault [] (Array.get (k + 1 + offset) v)

        ( path, ( x, y ) ) =
            case ( fromLeft, fromTop ) of
                ( [], [] ) ->
                    ( [], ( 0, 0 ) )

                ( [], ( topX, topY ) :: _ ) ->
                    ( fromTop, ( topX + 1, topY ) )

                ( ( leftX, leftY ) :: _, [] ) ->
                    ( fromLeft, ( leftX, leftY + 1 ) )

                ( ( leftX, leftY ) :: _, ( topX, topY ) :: _ ) ->
                    -- this implies "remove" comes always earlier than "add"
                    if leftY + 1 >= topY then
                        ( fromLeft, ( leftX, leftY + 1 ) )

                    else
                        ( fromTop, ( topX + 1, topY ) )

        ( newPath, goal ) =
            snake_ (x + 1) (y + 1) (( x, y ) :: path)
    in
    if goal then
        Found newPath

    else
        Continue (Array.set (k + offset) newPath v)


snake :
    (Int -> Maybe c)
    -> (Int -> Maybe c)
    -> Int
    -> Int
    -> List ( Int, Int )
    -> ( List ( Int, Int ), Bool )
snake getA getB nextX nextY path =
    case ( getA nextX, getB nextY ) of
        ( Just a, Just b ) ->
            if a == b then
                snake
                    getA
                    getB
                    (nextX + 1)
                    (nextY + 1)
                    (( nextX, nextY ) :: path)

            else
                ( path, False )

        -- reached bottom-right corner
        ( Nothing, Nothing ) ->
            ( path, True )

        _ ->
            ( path, False )
