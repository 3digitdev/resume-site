module About exposing (renderBio, socialLink)

import Helpers exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ionicon.Ios as IonIos
import Ionicon.Social as IonSoc


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
