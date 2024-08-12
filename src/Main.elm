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
        [ "I am a team leader and developer with experience across the whole stack, including QA. I have spent my career advocating for good developer experience, better documentation, and no premature optimization. Perfect is the enemy of good, and the most important feature of a project is that it's being used."
        , "I am looking to expand my skills as a leader, and help usher other developers to the heights they want to achieve as well. I have experience leading multiple teams working on production applications, and making important decisions on structure, architecture, and scoping."
        ]
    }


myWorkHistory : Maybe WorkHistoryPage
myWorkHistory =
    Just
        [ Job
            "Tactiq (f.k.a. DSD Partners)"
            "November 2023"
            "Present"
            "Team Lead, Backend"
            [ TextItem "Lead a small team of backend engineers developing new features for an application running entirely on AWS technology, used by multiple large corporations including Dollar General to manage out of stock inventories and requests for restock for DSD goods."
            , TextItem "During employment, we acquired a competing company, and I spearheaded the initial research and investigations into not only integrating our two products, but also migrating our current offering from AWS to Google Cloud."
            , TextItem "Led efforts to massively increase the productivity of our team by adopting better coding standards, cleaning up our code usage, and guiding the team on best design principles for a serverless backend."
            ]
        , Job
            "Vendr, Inc"
            "May 2023"
            "November 2023"
            "Senior Backend Engineer"
            [ TextItem "Worked for a short time with a small team on a Typescript + GraphQL-based backend for a widescale production application, with my primary focus being on helping build integrations with external tools and applications."
            , TextItem "Short stint at this role due to receiving a very enticing offer from one of my previous supervisors to work at Tactiq."
            ]
        , Job
            "Onebrief"
            "June 2022"
            "May 2023"
            "Senior Fullstack Software Engineer"
            [ TextItem "Entered into a small team of developers and a company looking to take off, and have been helping push out features at a rapidfire pace to help get the company going"
            , TextItem "Got in-depth knowledge of new technologies including collaborative editing using Operation Transformations"
            , TextItem "Production experience with React building on my personal project knowledge of the framework"
            , TextItem "Helped polish our Postgres database and built many triggers to help with data validation and syncing"
            ]
        , Job
            "DataKitchen"
            "March 2020"
            "May 2022"
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
                []
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
            [ Skill "Python" 5.0 "Primary (and favorite!) language; many years of industry experience with large microservice codebases including REST APIs"
            , Skill "Elm" 2.5 "Current favorite hobby web language; no industry experience"
            , Skill "JS/TS" 4.0 "Heavily used in industry experience and personal projects"
            , Skill "AWS" 4.0 "Heavily used for project entirely built on AWS serverless technologies"
            , Skill "Elixir" 3.0 "Enjoyable language being used on hobby projects and to get further FP practice"
            , Skill "React" 3.0 "Heavily used in recent industry experience, using modern concepts like functional components and hooks"
            , Skill "PostgreSQL" 3.5 "Heavily used in both personal projects and industry experience; my go-to database now"
            , Skill "Regex" 4.5 "Very knowledgeable up to advanced topics; Used heavily whenever I can, but never in true production code"
            ]
        }


myPortfolio : Maybe PortfolioPage
myPortfolio =
    Just
        { items =
            [ PortfolioItem
                "Pokemon App"
                [ LinkCard "https://dex.3digit.dev/" "Sw/Sh/Sc/Vi Dex"
                , LinkCard "https://github.com/3digitdev/swshdex/" "Github Repo"
                , TextCard "Description"
                    [ TextItem "Helper app for Pokemon Sword/Shield/Scarlet/Violet"
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
                    , TextItem "Data is handled with static JSON files for now (See README on why I'm not using an API)"
                    , LinkItem "https://github.com/nostalgic-css/NES.css" "CSS is provided by NES.css"
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
                    [ TextItem "This resume website is built on an unmodified fork of the project! (Only code modified is in 'Main.elm' to define resume parts)" ]
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
