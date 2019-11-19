module Resume exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Ionicon as Ion
import Ionicon.Ios as IonIos
import Ionicon.Social as IonSoc
import List.Extra exposing (greedyGroupsOf, last)
import Maybe.Extra exposing (unwrap)
import ResumePage.About exposing (..)
import ResumePage.Education exposing (..)
import ResumePage.Helpers exposing (..)
import ResumePage.Portfolio exposing (..)
import ResumePage.Skills exposing (..)
import ResumePage.WorkHistory exposing (..)



-- PUBLIC FUNCTIONS


type alias Resume =
    { nickname : Maybe String -- Short name to use for page title, etc
    , aboutPage : AboutPage
    , workHistoryPage : Maybe WorkHistoryPage
    , educationPage : Maybe EducationPage
    , skillsPage : Maybe SkillsPage
    , portfolioPage : Maybe PortfolioPage
    }


defaultResume : Resume
defaultResume =
    { nickname = Just "Max"
    , aboutPage = defaultAboutPage
    , workHistoryPage = Just defaultWorkHistory
    , educationPage = Just defaultEducation
    , skillsPage = Just defaultSkillsPage
    , portfolioPage = Just defaultPortfolio
    }


renderResume : SelectedPage -> Resume -> List (Html msg)
renderResume curPage resume =
    [ div
        [ class "container" ]
        [ div [ class "row" ]
            [ div
                [ class "nine columns center-text" ]
                [ h1 [] [ span [ class "page-header" ] [ text (pageString curPage) ] ] ]
            ]
        , renderNavBar resume curPage
        , div [ class "row content" ]
            [ div
                [ class "nine columns" ]
                [ curPage |> renderSelectedPage resume ]
            , div [ class "three columns" ] []
            ]
        ]
    ]


renderSelectedPage : Resume -> SelectedPage -> Html msg
renderSelectedPage resume selectedPage =
    case selectedPage of
        About ->
            resume.aboutPage |> renderAboutPage

        Work ->
            resume.workHistoryPage |> emptyDivOr renderWorkHistoryPage

        Education ->
            resume.educationPage |> emptyDivOr renderEducationPage

        Skills ->
            resume.skillsPage |> emptyDivOr renderSkillsPage

        Portfolio ->
            resume.portfolioPage |> emptyDivOr renderPortfolioPage


renderNavBar : Resume -> SelectedPage -> Html msg
renderNavBar resume curPage =
    let
        validPages =
            List.concat
                [ [ About ]
                , resume.workHistoryPage |> unwrap [] (\_ -> List.singleton Work)
                , resume.educationPage |> unwrap [] (\_ -> List.singleton Education)
                , resume.skillsPage |> unwrap [] (\_ -> List.singleton Skills)
                , resume.portfolioPage |> unwrap [] (\_ -> List.singleton Portfolio)
                ]
    in
    div [ class "three columns nav-bar full-shadow" ]
        (validPages |> List.map (navLink curPage))


navLink : SelectedPage -> SelectedPage -> Html msg
navLink curPage renderPage =
    let
        navClass =
            if renderPage == curPage then
                "nav current"

            else
                "nav"
    in
    a
        [ class "nav-link"
        , href (pageLink renderPage)

        -- TODO:  NEED TO FIGURE OUT HOW TO PASS A `Msg` FROM THE USER'S Main.elm!!  `msg` as arg didn't work!
        -- , onClick (NavClicked renderPage)
        ]
        [ h4
            [ class navClass ]
            [ pageIcon renderPage white, text (pageString renderPage) ]
        ]


{-| USING THE LIBRARY
Resume Object
need to define what pages you'll include
how to include/exclude them that's easiest?

    has one property for each page as a Maybe Page

Page Objects
list of the components in the page
varies by page

-}



-- TODO:  EVERYTHING BELOW HERE SHOULD BE DELETED WHEN WE ARE FINISHED
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
                -- TODO: Make id include index of item somehow
                [ id (String.toLower name), class "hidden inline", type_ "submit" ]
                []
            ]
        ]


renderBio : List (Html msg)
renderBio =
    [ div [ class "avatar" ] [ img [ src "square.png" ] [] ] -- TODO:  this needs to be an image
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
