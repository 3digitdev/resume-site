module Resume exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Ionicon as Ion
import Ionicon.Ios as IonIos
import Ionicon.Social as IonSoc
import List.Extra exposing (greedyGroupsOf, last)



-- TODO:
-- PUBLIC FUNCTIONS
-- ABOUT PAGE


socialLink : String -> String -> (Int -> RGBA -> Html msg) -> Html msg
socialLink name url icon =
    a [ href url, class "nav-link", title url ]
        [ Html.form
            [ class "inline", action url ]
            [ label
                [ for (String.toLower name), class "social inline" ]
                [ icon 32 white, text name ]
            , input
                [ id (String.toLower name), class "hidden inline", type_ "submit" ]
                []
            ]
        ]


renderBio : List (Html msg)
renderBio =
    [ div [ class "avatar" ] [ IonIos.contact 256 white ]
    , h2 [ class "about full-name" ] [ text "Max Andrew Bach Bussiere" ]
    , h5 [ class "about" ] [ text "Milwaukee 一 WI 一 U.S.A." ]
    , img [ class "about email", src "email.png" ] [ text "email image" ]
    , h3 [ class "about" ] [ text "Social:" ]
    , p
        [ class "about" ]
        [ socialLink "GitHub" "https://github.com/3digitdev/" IonSoc.github
        , div [ class "inline spacer" ] []
        , socialLink "Twitter" "https://www.twitter.com/" IonSoc.twitter
        , div [ class "inline spacer" ] []
        , socialLink "Facebook" "https://www.facebook.com/" IonSoc.facebook
        , div [ class "inline spacer" ] []
        , socialLink "LinkedIn" "https://www.linkedin.com/in/maxbuss" IonSoc.linkedin
        , div [ class "inline spacer" ] []
        , socialLink "Website" "https://me.3digit.dev/" IonIos.world
        ]
    , hr [] []
    , div
        [ class "bio" ]
        [ h3 [ class "inline" ] [ text "Bio: " ]
        , p [ class "inline" ] [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." ]
        , p [] []
        , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." ]
        , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." ]
        ]
    ]



-- WORK HISTORY PAGE


renderJob : Job -> Html msg
renderJob job =
    div [ class "job row full-shadow" ]
        [ div [ class "four columns info-wrapper" ]
            [ span []
                [ h5 [ class "inline job-em" ] [ text "Employer: " ]
                , h6 [ class "job-info" ] [ text job.employer ]
                ]
            , span []
                [ h5 [ class "inline job-em" ] [ text "Dates: " ]
                , h6 [ class "job-info" ] [ text (formatStartEndDate job.startDate job.endDate) ]
                ]
            , span []
                [ h5 [ class "inline job-em" ] [ text "Title: " ]
                , h6 [ class "job-info" ] [ text job.title ]
                ]
            ]
        , div [ class "eight columns" ]
            [ ul [ class "job-resp" ]
                (renderInfoList job.info)
            ]
        ]



-- EDUCATION PAGE


educationInfo : EducationType -> List (Html msg)
educationInfo edType =
    case edType of
        Formal ed ->
            [ div [ class "four columns info-wrapper" ]
                [ span []
                    [ h5 [ class "inline ed-em" ] [ text "School: " ]
                    , h6 [ class "ed-info" ] [ text ed.school ]
                    ]
                , span []
                    [ h5 [ class "inline ed-em" ] [ text "Graduated: " ]
                    , h6 [ class "ed-info" ] [ text ed.gradDate ]
                    ]
                , span []
                    [ h5 [ class "inline ed-em" ] [ text "Degree: " ]
                    , h6 [ class "ed-info" ] [ text ed.degree ]
                    ]
                , span []
                    [ h5 [ class "inline ed-em" ] [ text "GPA: " ]
                    , h6 [ class "inline ed-em" ] [ text ed.gpa ]
                    ]
                ]
            , div [ class "eight columns" ]
                [ ul [ class "ed-resp" ] (renderInfoList ed.info) ]
            ]

        SelfEducated ed ->
            [ div [ class "four columns info-wrapper" ]
                [ span []
                    [ h5 [ class "inline ed-em" ] [ text "Self-Education" ]
                    ]
                ]
            , div [ class "eight columns ed-resp" ]
                [ ul [ class "ed-resp" ] (renderInfoList ed) ]
            ]

        Camp ed ->
            [ div [ class "four columns info-wrapper" ]
                [ span []
                    [ h5 [ class "inline ed-em" ] [ text "School: " ]
                    , h6 [ class "ed-info" ] [ a [ href ed.website ] [ text ed.school ] ]
                    ]
                , span []
                    [ h5 [ class "inline ed-em" ] [ text "Attendance: " ]
                    , h6 [ class "ed-info" ] [ text (formatStartEndDate ed.startDate ed.endDate) ]
                    ]
                ]
            , div [ class "eight columns ed-resp" ]
                [ ul [ class "ed-resp" ] (renderInfoList ed.info) ]
            ]


renderEducation : EducationType -> Html msg
renderEducation edType =
    div [ class "education row full-shadow" ]
        (educationInfo edType)



-- SKILLS PAGE


toStars : Float -> List (Html msg)
toStars rating =
    let
        -- Get half a star if the rating has more than 0 in tenths place
        ( stars, halfStar ) =
            if rating - toFloat (floor rating) > 0 then
                ( floor rating, 1 )

            else
                ( floor rating, 0 )

        emptyStars =
            5 - stars - halfStar
    in
    List.concat
        [ List.repeat stars (IonIos.star 24 white)
        , List.repeat halfStar (IonIos.starHalf 24 white)
        , List.repeat emptyStars (IonIos.starOutline 24 white)
        ]


renderSkill : Skill -> Html msg
renderSkill skill =
    div [ class "skill-card full-shadow" ]
        [ h4 [ class "center-text" ] [ text skill.name ]
        , h5 [ class "center-text" ] (skill.rating |> toStars)
        , p [] [ text skill.blurb ]
        ]



-- PORTFOLIO PAGE


renderCardGroup : List PortfolioCard -> Html msg
renderCardGroup cardGroup =
    div [ class "folio-cards" ]
        (List.map
            (\card ->
                case card of
                    TextCard title items ->
                        div []
                            [ h6 [ class "folio-em center-text" ] [ text title ]
                            , ul [ class "folio-card" ] (renderInfoList items)
                            ]

                    ImageCard imgPath ->
                        div [ class "folio-image" ]
                            [ img [ src imgPath ] [] ]

                    LinkCard url txt ->
                        div [ class "center-text folio-link" ]
                            [ a [ href url ]
                                [ div []
                                    [ Ion.link 40 white
                                    , h3 [] [ text txt ]
                                    ]
                                ]
                            ]
            )
            cardGroup
        )


renderPortfolioItem : PortfolioItem -> Html msg
renderPortfolioItem item =
    div [ class "folio-item full-shadow" ]
        [ div []
            [ div
                [ class "folio-title center-text" ]
                [ h2 [] [ text item.title ] ]
            ]
        , renderCardGroup item.cards
        ]



-- INTERNAL HELPER FUNCTIONS


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
    case String.split "/" url |> last of
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


formatStartEndDate : String -> String -> String
formatStartEndDate start end =
    if end == "" || end == "Present" then
        start ++ " ⟹ " ++ "Present"

    else
        start ++ " ⟹ " ++ end



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



-- TYPEDEFS


type alias Job =
    { employer : String
    , startDate : String
    , endDate : String
    , title : String
    , info : List InfoItem
    }


type alias FormalEd =
    { school : String
    , gradDate : String
    , degree : String
    , gpa : String
    , info : List InfoItem
    }


type alias BootCamp =
    { school : String
    , website : String
    , startDate : String
    , endDate : String
    , info : List InfoItem
    }


type EducationType
    = Formal FormalEd
    | SelfEducated (List InfoItem)
    | Camp BootCamp


type alias Skill =
    { name : String
    , rating : Float
    , blurb : String
    }


type alias PortfolioItem =
    { title : String
    , cards : List PortfolioCard
    }


type PortfolioCard
    = TextCard String (List InfoItem) -- Pure text with title as <ul> with text or links
    | ImageCard String -- Just an image filling the card with capped width/height
    | LinkCard String String -- A card that has just a single link -- entire card is clickable


type Page
    = About
    | Work
    | Education
    | Skills
    | Portfolio


type InfoItem
    = LinkItem String String
    | TextItem String
