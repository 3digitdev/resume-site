module Helpers exposing
    ( InfoItem(..)
    , Page(..)
    , RGBA
    , anchorToPage
    , formatStartEndDate
    , pageIcon
    , pageLink
    , pageString
    , renderInfoList
    , urlToPage
    , white
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Ionicon as Ion
import Ionicon.Ios as IonIos
import Ionicon.Social as IonSoc
import List.Extra exposing (last)
import String exposing (split)



-- COLORS


type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


white : RGBA
white =
    RGBA 1 1 1 1



-- PAGE STUFF


type Page
    = About
    | Work
    | Education
    | Skills
    | Portfolio


pageString : Page -> String
pageString page =
    case page of
        About ->
            "About"

        Work ->
            "Work History"

        Education ->
            "Education"

        Skills ->
            "Skills"

        Portfolio ->
            "Portfolio"


pageLink : Page -> String
pageLink page =
    case page of
        About ->
            "about"

        Work ->
            "work"

        Education ->
            "education"

        Skills ->
            "skills"

        Portfolio ->
            "portfolio"


anchorToPage : String -> Page
anchorToPage anchor =
    case anchor of
        "Work" ->
            Work

        "Education" ->
            Education

        "Skills" ->
            Skills

        "Portfolio" ->
            Portfolio

        _ ->
            About


urlToPage : String -> Page
urlToPage url =
    case split "/" url |> last of
        Nothing ->
            About

        Just urlStr ->
            case urlStr of
                "work" ->
                    Work

                "education" ->
                    Education

                "skills" ->
                    Skills

                "portfolio" ->
                    Portfolio

                _ ->
                    About


pageIcon : Page -> RGBA -> Html msg
pageIcon page color =
    let
        size =
            30
    in
    case page of
        About ->
            IonIos.contact size color

        Work ->
            Ion.coffee size color

        Education ->
            Ion.university size color

        Skills ->
            IonIos.lightbulb size color

        Portfolio ->
            Ion.briefcase size color



-- INFO ITEMS


type InfoItem
    = LinkItem String String
    | TextItem String


renderInfoList : List InfoItem -> List (Html msg)
renderInfoList infoList =
    List.map
        (\item ->
            case item of
                TextItem txt ->
                    li [] [ text txt ]

                LinkItem url txt ->
                    li [] [ a [ href url ] [ text txt ] ]
        )
        infoList



-- MISC


formatStartEndDate : String -> String -> String
formatStartEndDate start end =
    if end == "" || end == "Present" then
        start ++ " ⟹ " ++ "Present"

    else
        start ++ " ⟹ " ++ end
