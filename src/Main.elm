module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Ionicon as Ion
import Ionicon.Ios as IonIos
import Ionicon.Social as IonSoc
import List.Extra exposing (last)
import String exposing (split)
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


type Page
    = About
    | Work
    | Education
    | Skills
    | Portfolio


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
    , page = Work
    , title = pageTitle Work
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
            , div [ class "row" ]
                [ div
                    [ class "nine columns" ]
                    [ renderBody model ]
                , renderNavBar model
                ]
            ]
        ]
    }


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


pageIcon : Page -> RGBA -> Html Msg
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


socialLink : String -> String -> (Int -> RGBA -> Html Msg) -> Html Msg
socialLink name url icon =
    Html.form
        [ class "inline", action url ]
        [ label
            [ for (String.toLower name), class "social inline" ]
            [ icon 32 white, text name ]
        , input
            [ id (String.toLower name), class "hidden inline", type_ "submit" ]
            []
        ]


type alias Job =
    { employer : String
    , startDate : String
    , endDate : String
    , title : String
    , info : List String
    }


formatJobDate : Job -> String
formatJobDate job =
    if job.endDate == "" || job.endDate == "Present" then
        job.startDate ++ " ⟹ " ++ "Present"

    else
        job.startDate ++ " ⟹ " ++ job.endDate


renderJob : Job -> Html Msg
renderJob job =
    div [ class "job row" ]
        [ div [ class "four columns info-wrapper" ]
            [ span []
                [ h6 [ class "inline job-em" ] [ text "Employer: " ]
                , p [ class "job-info" ] [ text job.employer ]
                ]
            , span []
                [ h6 [ class "inline job-em" ] [ text "Dates: " ]
                , p [ class "job-info" ] [ text (formatJobDate job) ]
                ]
            , span []
                [ h6 [ class "inline job-em" ] [ text "Title: " ]
                , p [ class "job-info" ] [ text job.title ]
                ]
            ]
        , div [ class "eight columns" ]
            [ ul [ class "job-resp" ]
                (List.map
                    (\item -> li [] [ text item ])
                    job.info
                )
            ]
        ]


renderBody : Model -> Html Msg
renderBody model =
    case model.page of
        About ->
            div []
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
                , div
                    [ class "bio" ]
                    [ h3 [ class "inline" ] [ text "Bio: " ]
                    , p [ class "inline" ] [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." ]
                    , p [] []
                    , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." ]
                    , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." ]
                    ]
                ]

        Work ->
            div []
                [ Job
                    "Northwestern Mutual"
                    "July 2017"
                    "Present"
                    "Senior Test Engineer"
                    [ "Lead tester on a brand new rewrite of front-end for a large enterprise application"
                    , "Developed automation strategy to make end-to-end tests run 3x faster with no loss of reliability"
                    , "Lead training classes for helping test engineers learn API testing"
                    , "Scripted automation of hundreds of tests covering a large application"
                    , "Developed process, documentation, and organization of actual codebase and test codebase"
                    , "Helped to greatly improve reliability, cleanliness, and organization of entire testing repo"
                    ]
                    |> renderJob
                , Job
                    "Schweitzer Engineering Labs, Inc."
                    "February 2014"
                    "June 2017"
                    "Software Engineer"
                    []
                    |> renderJob
                ]

        Education ->
            div []
                [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                ]

        Skills ->
            div []
                [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                ]

        Portfolio ->
            div []
                [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                ]


renderNavBar : Model -> Html Msg
renderNavBar model =
    div [ class "three columns nav-bar" ]
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
