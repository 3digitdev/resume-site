module Education exposing (BootCamp, EducationType(..), FormalEd, educationInfo, renderEducation)

import Helpers exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


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
