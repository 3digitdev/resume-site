module Jobs exposing (Job, renderJob)

import Helpers exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Job =
    { employer : String
    , startDate : String
    , endDate : String
    , title : String
    , info : List InfoItem
    }


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
