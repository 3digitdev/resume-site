module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import About exposing (..)
import Browser
import Browser.Navigation as Nav
import Education exposing (..)
import Helpers exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Ionicon as Ion
import Ionicon.Ios as IonIos
import Ionicon.Social as IonSoc
import Jobs exposing (..)
import List.Extra exposing (greedyGroupsOf)
import Portfolio exposing (..)
import Skills exposing (..)
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



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , page : Page
    , title : String
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( initModel url key, Cmd.none )


initModel : Url.Url -> Nav.Key -> Model
initModel url key =
    { key = key
    , url = url
    , page = Portfolio
    , title = pageTitle Portfolio
    }


pageTitle : Page -> String
pageTitle page =
    "Max Bussiere | " ++ pageString page



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NavClicked Page


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
            ( { model | url = url, page = page, title = pageTitle page }, Cmd.none )

        NavClicked page ->
            ( { model | page = page }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = model.title
    , body =
        [ div
            [ class "container" ]
            [ div [ class "row" ]
                [ div
                    [ class "nine columns center-text" ]
                    [ h1 [] [ span [ class "page-header" ] [ text (pageString model.page) ] ] ]
                ]
            , renderNavBar model
            , div [ class "row content" ]
                [ div
                    [ class "nine columns" ]
                    [ renderBody model ]
                , div [ class "three columns" ] []
                ]
            ]
        ]
    }


renderBody : Model -> Html Msg
renderBody model =
    case model.page of
        About ->
            div [ id "About" ]
                renderBio

        Work ->
            div [ id "Work" ]
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
                    |> renderJob
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
                    |> renderJob
                , Job
                    "Guidance Software"
                    "August 2012"
                    "July 2013"
                    "Professional Services Consultant"
                    [ TextItem "Became certified with \"EnCase\", a cybersecurity forensics software suite"
                    , TextItem "Working with outside companies to install, troubleshoot, and instruct on EnCase"
                    , TextItem "Using Guidance's proprietary language as well as C# to create connections between outside software and EnCase."
                    ]
                    |> renderJob
                ]

        Education ->
            div [ id "Education" ]
                [ FormalEd
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
                    |> Formal
                    |> renderEducation
                , BootCamp
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
                    |> Camp
                    |> renderEducation
                , [ TextItem "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
                  , TextItem "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                  , TextItem "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
                  , TextItem "ut aliquip ex ea commodo consequat. Duis aute irure dolor in"
                  , TextItem "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
                  , TextItem "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                  ]
                    |> SelfEducated
                    |> renderEducation
                ]

        Skills ->
            div [ id "Skills", class "skill-list" ]
                ([ Skill "Python" 4.5 "Primary hobby language, no industry experience (but VERY much wanted)"
                 , Skill "Elm" 2.5 "Current favorite hobby web language, no industry experience (also very much wanted)"
                 , Skill "Nim" 2.0 "New backend compiled language to learn metaprogramming"
                 , Skill "JavaScript" 3.5 "Heavily used in industry experience, including production apps"
                 , Skill "C#" 3.5 "Heavily used in industry experience, including several production apps"
                 , Skill "Regex" 4.0 "Very knowledgeable up to advanced topics; Used heavily whenever I can"
                 ]
                    |> List.map renderSkill
                )

        Portfolio ->
            div [ id "Portfolio" ]
                (List.map renderPortfolioItem
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
                )


renderNavBar : Model -> Html Msg
renderNavBar model =
    div [ class "three columns nav-bar full-shadow" ]
        [ navLink model About
        , navLink model Work
        , navLink model Education
        , navLink model Skills
        , navLink model Portfolio
        ]


navLink : Model -> Page -> Html Msg
navLink model page =
    let
        navClass =
            if model.page == page then
                "nav current"

            else
                "nav"
    in
    a
        [ class "nav-link"
        , href (pageLink page)
        , onClick (NavClicked page)
        ]
        [ h4
            [ class navClass ]
            [ pageIcon page white, text (pageString page) ]
        ]
