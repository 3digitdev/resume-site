module ResumePage.WorkHistory exposing
    ( Job
    , WorkHistoryPage
    , defaultWorkHistory
    , renderWorkHistoryPage
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import ResumePage.Helpers exposing (..)


type alias WorkHistoryPage =
    List Job


type alias Job =
    { employer : String
    , startDate : String
    , endDate : String
    , title : String
    , info : List InfoItem
    }


defaultWorkHistory : WorkHistoryPage
defaultWorkHistory =
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


renderWorkHistoryPage : WorkHistoryPage -> Html msg
renderWorkHistoryPage workPage =
    div [ id "Work" ]
        (workPage |> List.map renderJob)


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
