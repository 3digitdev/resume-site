module Main exposing (Model, Msg(..), init, main, subscriptions, update, view, viewLink)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
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
    | Contact
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
    , page = About
    , title = pageTitle ""
    }


pageTitle : String -> String
pageTitle subpage =
    "Max Bussiere | " ++ subpage



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
            ( { model | url = url }, Cmd.none )

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
                    [ class "ten columns center-text" ]
                    [ h1 [] [ text (pageString model.page) ] ]
                ]
            , div [ class "row" ]
                [ div
                    [ class "ten columns" ]
                    [ renderBody model ]
                , renderNavBar model
                ]
            ]
        ]

    -- [ text "The current URL is: "
    -- , b [] [ text (Url.toString model.url) ]
    -- , ul []
    --     [ viewLink "/home"
    --     , viewLink "/profile"
    --     , viewLink "/reviews/the-century-of-the-self"
    --     , viewLink "/reviews/public-opinion"
    --     , viewLink "/reviews/shah-of-shahs"
    --     ]
    -- ]
    }


pageString : Page -> String
pageString page =
    case page of
        About ->
            "About"

        Contact ->
            "Contact"

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

        Contact ->
            "contact"

        Work ->
            "work"

        Education ->
            "education"

        Skills ->
            "skills"

        Portfolio ->
            "portfolio"


renderBody : Model -> Html Msg
renderBody model =
    case model.page of
        About ->
            div []
                [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                ]

        Contact ->
            div [] []

        Work ->
            div [] []

        Education ->
            div [] []

        Skills ->
            div [] []

        Portfolio ->
            div [] []


renderNavBar : Model -> Html Msg
renderNavBar model =
    div [ class "two columns nav-border center-text" ]
        [ navLinkNotLast model About
        , navLinkNotLast model Contact
        , navLinkNotLast model Work
        , navLinkNotLast model Education
        , navLinkNotLast model Skills
        , navLink model Portfolio "nav-last"
        ]


navLinkNotLast : Model -> Page -> Html Msg
navLinkNotLast model page =
    navLink model page ""


navLink : Model -> Page -> String -> Html Msg
navLink model page extra =
    a
        [ class "nav-link"
        , href (pageLink page)
        , onClick (NavClicked page)
        ]
        [ h4
            [ class (navClass model page ++ " " ++ extra) ]
            [ text (pageString page) ]
        ]


navClass : Model -> Page -> String
navClass model page =
    if model.page == page then
        "nav-current"

    else
        ""


viewLink : String -> Html msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]
