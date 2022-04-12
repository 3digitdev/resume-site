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
    { avatar = Just "3DD.svg"
    , name = "Max Andrew Bach Bussiere"
    , city = Just "Bowling Green"
    , stateOrProv = Just "Kentucky"
    , country = Just "USA"
    , email = Just (ImageEmail "email3dd.png")
    , socialLinks =
        [ GitHub "https://github.com/3digitdev/"
        , LinkedIn "https://www.linkedin.com/in/max-bussiere"
        , Website "https://me.3digit.dev/"
        ]
    , bio =
        [ "As a developer, I am a leader, an architect, and a Developer Experience advocate.  I love good documentation, clean code, and using the right tools without chasing hype without other reasons.  I am a proven 10X developer on my teams, delivering high quality code in a fraction of the time expected of me.  I am curious, and will dive into new topics to solve them no matter what."
        , "As a leader, I have experience mentoring, tutoring, and decision making.  I know that one of a leader's primary jobs is to be a goalie for their team, to get out of their way, and get other things out of their way so they can succeed.  I need to be, and am, a force multiplier for any developers I work with, and understand the politics of business well enough to play the game for the devs so they can focus on shipping."
        , "As a communicator, I am eloquent and charismatic.  I take pride in my communication skills (writing AND speaking) and have public speaking skills as well as the ability to explain complex topics and understand the needs of those I'm speaking with to help people understand each other."
        , "I am also a professional 'no' man -- I will tell you the truth no matter what title you hold, or what your experience is, and I will keep an entire team honest on their decisions and discussion.  You can disagree with me, and I can disagree with you, but in the end I don't take offense and hope the same of you.  I can 'disagree and commit'.  I understand not everything can be discussed to death, and the most important thing is to ship a product in the end.  Perfect is the enemy of good, but I will help you get as close to perfect as possible."
        , "I am a developer, a leader, a communicator, and an architect.  You want me on your team, I promise."
        ]
    }


myWorkHistory : Maybe WorkHistoryPage
myWorkHistory =
    Just
        [ Job
            "DataKitchen"
            "March 2020"
            "Present"
            "Lead Engineer, API Team"
            [ TextItem "Team lead of 4 engineers for the DataKitchen API and accompanying CLI app"
            , TextItem "Conceptualized, designed, planned, and currently executing a large-scale refactor of our API to a new major version using well-defined REST principles and usability features"
            , TextItem "Helping lead the way for better code quality, better tests, and most importantly better documentation of our architecture"
            , TextItem "Mentoring and on-boarding of multiple engineers at various skill levels with our codebase and teaching them code quality techniques"
            , TextItem "Customer-facing support rotation and helping debug issues live on a K8s cluster"
            , TextItem "Working with a combination of Customers, UX designer, Product Owners, and Front-end team to deliver code that works well and is helpful, along with defining realistic features and plans"
            ]
        , Job
            "Northwestern Mutual"
            "July 2017"
            "March 2020"
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
                [ TextItem "Was a tutor for the Computer Science department for 100, 200, and 300 level classes"
                , TextItem "Primarily worked with C/C++, JavaScript, and Python"
                ]
            ]
        , bootCamps = []
        , otherEducation =
            OtherEducation
                [ TextItem "Have done extensive work on my own time to learn new technologies and languages"
                , TextItem "Have studied both frontend and backend languages/frameworks"
                , TextItem "Deploy and manage self-made webapps with full CI/CD pipeline"
                , TextItem "Have taken online courses at times for various things including AWS and React"
                ]
        }


mySkills : Maybe SkillsPage
mySkills =
    Just
        { skills =
            [ Skill "Python" 4.5 "Primary (and favorite!) language; several years of industry experience with large microservice codebase including a REST API and CLI app"
            , Skill "Elm" 3.0 "Current favorite hobby web language; no industry experience (also very much wanted)"
            , Skill "Nim" 2.5 "New backend compiled language that lets me enjoy compiled languages again with many of the benefits of Python"
            , Skill "JavaScript" 3.5 "Heavily used in industry experience, including production apps, though not high on my list of favorite language :D"
            , Skill "C#" 3.5 "Heavily used in industry experience, including several production apps"
            , Skill "Regex" 4.0 "Very knowledgeable up to advanced topics; Used heavily whenever I can, but never in true production code :D"
            ]
        }


myPortfolio : Maybe PortfolioPage
myPortfolio =
    Just
        { items =
            [ PortfolioItem
                "Sw/Sh Pokemon App"
                [ LinkCard "https://dex.3digit.dev/" "Sw/Sh Dex"
                , LinkCard "https://github.com/3digitdev/swshdex/" "Github Repo"
                , TextCard "Description"
                    [ TextItem "Helper app for Pokemon Sword/Shield"
                    , TextItem "Has 3 different 'modes' you can use to help when playing"
                    ]
                , TextCard "Modes"
                    [ TextItem "Pokedex Mode:  Allows searching by name. Links types to Type Matchup Mode"
                    , TextItem "Type Matchup Mode:  Select 1-2 types, and get information about the type regarding offense, defense, and suggested Pokemon"
                    , TextItem "Party Planner Mode:  Enter your party members in and get an evaluation of your party regarding type matchups, including suggestions on types to fill gaps"
                    ]
                , ImageCard "swshdex-pp.png"
                , TextCard "Tech Stack"
                    [ TextItem "Entire app is written in Elm"
                    , LinkItem "https://elm-lang.org/" "Elm Language"
                    , TextItem "Data is handled with static JSON files for now"
                    , TextItem "(See README on why I'm not using an API)"
                    , TextItem "CSS is provided by:"
                    , LinkItem "https://github.com/nostalgic-css/NES.css" "NES.css"
                    ]
                ]
            , PortfolioItem
                "Verbly"
                [ LinkCard "https://verbly.3digit.dev/" "Verbly"
                , TextCard "Description"
                    [ TextItem "Verb conjugation practice"
                    , TextItem "Currently supports only Italian"
                    , TextItem "Has timed mini-game for practice"
                    , TextItem "Has fuzzy-search and reverse search of 500+ verbs"
                    ]
                , TextCard "Tech Stack"
                    [ TextItem "Backend is Nim exposing REST API"
                    , LinkItem "https://nim-lang.org/" "Nim Language"
                    , TextItem "Database is SQLite"
                    , TextItem "Frontend is in Elm with Materialize CSS"
                    , LinkItem "https://elm-lang.org/" "Elm Language"
                    , LinkItem "https://materializecss.com/" "Materialize CSS"
                    ]
                , ImageCard "verbly-ta.png"
                , ImageCard "verbly-tr.png"
                , TextCard "CI/CD"
                    [ TextItem "App is deployed on semver tags"
                    , TextItem "GitHub Action deploys the Elm portion to Firebase"
                    , TextItem "Google Cloud Platform triggers off semver tag"
                    , TextItem "Nim backend API deploys to a Docker image running on Google Cloud"
                    ]
                ]
            , PortfolioItem
                "Elm Resume Site Generator"
                [ LinkCard "https://github.com/3digitdev/elm-resume-site" "GitHub Repo"
                , TextCard "Information"
                    [ TextItem "OpenSource Elm-based generator"
                    , TextItem "Builds a fully-modular resume SPA"
                    , TextItem "Fully responsive CSS for all devices"
                    ]
                , TextCard "Fun Fact"
                    [ TextItem "This resume website is built on an unmodified fork of the project!"
                    , TextItem "Only code modified is in 'Main.elm' to define resume parts"
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
