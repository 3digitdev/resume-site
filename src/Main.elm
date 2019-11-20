module Main exposing
    ( Model
    , Msg(..)
    , init
    , main
    , subscriptions
    , update
    , view
    )

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Maybe.Extra exposing (unwrap)
import Resume exposing (Resume)
import ResumePage.Helpers exposing (..)
import ResumePage.Types exposing (..)
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- RESUME DEFINITION


myResume : Resume
myResume =
    Resume
        aboutMe
        myWorkHistory
        myEducation
        mySkills
        myPortfolio


aboutMe : AboutPage
aboutMe =
    { avatar = Just "square.png"
    , name = "Max Andrew Bach Bussiere"
    , city = Just "Milwaukee"
    , stateOrProv = Just "Wisconsin"
    , country = Just "USA"
    , email = Just (ImageEmail "email.png")
    , socialLinks =
        [ GitHub "https://github.com/3digitdev/"
        , Twitter "https://www.twitter.com/"
        , Facebook "https://www.facebook.com/"
        , LinkedIn "https://www.linkedin.com/in/maxbuss"
        , Website "https://me.3digit.dev/"
        ]
    , bio =
        [ "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        , "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        , "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        ]
    }


myWorkHistory : Maybe WorkHistoryPage
myWorkHistory =
    Just
        [ Job
            "Northwestern Mutual"
            "July 2017"
            "Present"
            "Senior Test Engineer"
            [ TextItem "Lead tester on a brand new rewrite of front-end for a large enterprise application"
            , TextItem "Developed automation strategy to make end-to-end tests run 3x faster with no loss of reliability"
            , TextItem "Lead training classes for helping test engineers learn API testing"
            , TextItem "Scripted automation of hundreds of tests covering a large application"
            , TextItem "Developed process, documentation, and organization of actual codebase and test codebase"
            , TextItem "Helped to greatly improve reliability, cleanliness, and organization of entire testing repo"
            ]
        , Job
            "Schweitzer Engineering Labs, Inc."
            "February 2014"
            "June 2017"
            "Software Engineer"
            [ TextItem "Helped to create and bring to production the SEL-5056 Software Defined Networking tool"
            , LinkItem "https://cdn.selinc.com/assets/Literature/Product%20Literature/Data%20Sheets/5056_DS_20190614.pdf?v=20190703-203312" "SEL-5056 SDN"
            , TextItem "Developed automation testing suite using Python and Mininet to help create a VM 'farm' to build a fake network for testing"
            , TextItem "Helped to create a heavily-OOP C# application to customer specifications"
            ]
        , Job
            "Guidance Software"
            "August 2012"
            "July 2013"
            "Professional Services Consultant"
            [ TextItem "Became certified with \"EnCase\", a cybersecurity forensics software suite"
            , TextItem "Working with outside companies to install, troubleshoot, and instruct on EnCase"
            , TextItem "Using Guidance's proprietary language as well as C# to create connections between outside software and EnCase."
            ]
        ]


myEducation : Maybe EducationPage
myEducation =
    Just
        { formalEducation =
            [ FormalEducation
                "Morningside College"
                "May 2012"
                "B.S. Computer Science"
                "3.2"
                [ TextItem "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
                , TextItem "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                , TextItem "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
                , TextItem "ut aliquip ex ea commodo consequat. Duis aute irure dolor in"
                , TextItem "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
                , TextItem "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                ]
            ]
        , bootCamps =
            [ BootCamp
                "DevCodeCamp"
                "https://devcodecamp.com/"
                "March 2015"
                "March 2016"
                [ TextItem "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
                , TextItem "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                , TextItem "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
                , TextItem "ut aliquip ex ea commodo consequat. Duis aute irure dolor in"
                , TextItem "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
                , TextItem "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                ]
            ]
        , otherEducation =
            OtherEducation
                [ TextItem "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
                , TextItem "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                , TextItem "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
                , TextItem "ut aliquip ex ea commodo consequat. Duis aute irure dolor in"
                , TextItem "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
                , TextItem "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                ]
        }


mySkills : Maybe SkillsPage
mySkills =
    Just
        { skills =
            [ Skill "Python" 4.5 "Primary hobby language, no industry experience (but VERY much wanted)"
            , Skill "Elm" 2.5 "Current favorite hobby web language, no industry experience (also very much wanted)"
            , Skill "Nim" 2.0 "New backend compiled language to learn metaprogramming"
            , Skill "JavaScript" 3.5 "Heavily used in industry experience, including production apps"
            , Skill "C#" 3.5 "Heavily used in industry experience, including several production apps"
            , Skill "Regex" 4.0 "Very knowledgeable up to advanced topics; Used heavily whenever I can"
            ]
        }


myPortfolio : Maybe PortfolioPage
myPortfolio =
    Just
        { items =
            [ PortfolioItem
                "Verbly"
                [ LinkCard "https://verbly.3digit.dev/" "Verbly"
                , TextCard "Description"
                    [ TextItem "Verb conjugation practice"
                    , TextItem "Currently supports only Italian"
                    , TextItem "Has timed mini-game for practice"
                    , TextItem "Has fuzzy-search and reverse search of 500+ verbs"
                    ]
                , ImageCard "verbly.png"
                , TextCard "Tech Stack"
                    [ TextItem "Backend is Nim exposing REST API"
                    , LinkItem "http://nim-lang.org/" "Nim Language"
                    , TextItem "Database is SQLite"
                    , TextItem "Frontend is in Elm with Materialize CSS"
                    , LinkItem "https://elm-lang.org/" "Elm Language"
                    , LinkItem "https://materializecss.com/" "Materialize CSS"
                    ]
                ]
            ]
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , page : SelectedPage
    , resume : Resume
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( initModel url key, Cmd.none )


initModel : Url.Url -> Nav.Key -> Model
initModel url key =
    { key = key
    , url = url
    , page = About
    , resume = myResume
    }



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NavClicked SelectedPage -- Absolutely necessary for Navigation Bar to work


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            let
                page =
                    urlToPage url.path
            in
            ( { model | url = url, page = page }, Cmd.none )

        NavClicked page ->
            ( { model | page = page }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = pageString model.page
    , body =
        [ div
            [ class "container" ]
            [ div [ class "row" ]
                [ div
                    [ class "nine columns center-text" ]
                    [ h1 [] [ span [ class "page-header" ] [ text (pageString model.page) ] ] ]
                ]
            , renderNavBar model.resume model.page
            , model.resume |> Resume.render model.page
            ]
        ]
    }


renderNavBar : Resume -> SelectedPage -> Html Msg
renderNavBar resume curPage =
    let
        -- figure out what pages the user is including in the resume, only render those
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


navLink : SelectedPage -> SelectedPage -> Html Msg
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
        , onClick (NavClicked renderPage)
        ]
        [ h4
            [ class navClass ]
            [ pageIcon renderPage white, text (pageString renderPage) ]
        ]
