module ResumePage.Education exposing
    ( BootCamp
    , EducationPage
    , FormalEducation
    , OtherEducation
    , defaultEducation
    , renderEducationPage
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import ResumePage.Helpers exposing (..)


type alias EducationPage =
    { formalEducation : List FormalEducation
    , bootCamps : List BootCamp
    , otherEducation : OtherEducation
    }


type alias FormalEducation =
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


type alias OtherEducation =
    { notes : List InfoItem }


defaultEducation : EducationPage
defaultEducation =
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


renderFormalEducation : FormalEducation -> List (Html msg)
renderFormalEducation formalEducation =
    [ div [ class "four columns info-wrapper" ]
        [ span []
            [ h5 [ class "inline ed-em" ] [ text "School: " ]
            , h6 [ class "ed-info" ] [ text formalEducation.school ]
            ]
        , span []
            [ h5 [ class "inline ed-em" ] [ text "Graduated: " ]
            , h6 [ class "ed-info" ] [ text formalEducation.gradDate ]
            ]
        , span []
            [ h5 [ class "inline ed-em" ] [ text "Degree: " ]
            , h6 [ class "ed-info" ] [ text formalEducation.degree ]
            ]
        , span []
            [ h5 [ class "inline ed-em" ] [ text "GPA: " ]
            , h6 [ class "inline ed-em" ] [ text formalEducation.gpa ]
            ]
        ]
    , div [ class "eight columns" ]
        [ ul [ class "ed-resp" ] (renderInfoList formalEducation.info) ]
    ]


renderOtherEducation : List InfoItem -> List (Html msg)
renderOtherEducation otherEducation =
    [ div [ class "four columns info-wrapper" ]
        [ span []
            [ h5 [ class "inline ed-em" ] [ text "Other/Self Education" ]
            ]
        ]
    , div [ class "eight columns ed-resp" ]
        [ ul [ class "ed-resp" ] (renderInfoList otherEducation) ]
    ]


renderBootCamp : BootCamp -> List (Html msg)
renderBootCamp bootCamp =
    [ div [ class "four columns info-wrapper" ]
        [ span []
            [ h5 [ class "inline ed-em" ] [ text "School: " ]
            , h6 [ class "ed-info" ] [ a [ href bootCamp.website ] [ text bootCamp.school ] ]
            ]
        , span []
            [ h5 [ class "inline ed-em" ] [ text "Attendance: " ]
            , h6 [ class "ed-info" ] [ text (formatStartEndDate bootCamp.startDate bootCamp.endDate) ]
            ]
        ]
    , div [ class "eight columns ed-resp" ]
        [ ul [ class "ed-resp" ] (renderInfoList bootCamp.info) ]
    ]


renderEducationPage : EducationPage -> Html msg
renderEducationPage eduPage =
    let
        formalEdDom =
            case eduPage.formalEducation of
                [] ->
                    [ emptyDiv ]

                formalEds ->
                    formalEds |> List.map renderFormalEducation |> List.concat

        bootCampsDom =
            case eduPage.bootCamps of
                [] ->
                    [ emptyDiv ]

                bootCamps ->
                    bootCamps |> List.map renderBootCamp |> List.concat

        otherEdDom =
            case eduPage.otherEducation.notes of
                [] ->
                    [ emptyDiv ]

                otherEd ->
                    otherEd |> renderOtherEducation
    in
    div [ id "Education" ]
        (List.concat [ formalEdDom, bootCampsDom, otherEdDom ])
