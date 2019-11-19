module ResumePage.Skills exposing (Skill, SkillsPage, defaultSkillsPage, renderSkillsPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Ionicon.Ios as IonIos
import ResumePage.Helpers exposing (..)


type alias SkillsPage =
    { skills : List Skill }


type alias Skill =
    { name : String
    , rating : Float
    , blurb : String
    }


defaultSkillsPage : SkillsPage
defaultSkillsPage =
    { skills =
        [ Skill "Python" 4.5 "Primary hobby language, no industry experience (but VERY much wanted)"
        , Skill "Elm" 2.5 "Current favorite hobby web language, no industry experience (also very much wanted)"
        , Skill "Nim" 2.0 "New backend compiled language to learn metaprogramming"
        , Skill "JavaScript" 3.5 "Heavily used in industry experience, including production apps"
        , Skill "C#" 3.5 "Heavily used in industry experience, including several production apps"
        , Skill "Regex" 4.0 "Very knowledgeable up to advanced topics; Used heavily whenever I can"
        ]
    }


toStars : Float -> List (Html msg)
toStars rating =
    let
        -- Get half a star if the rating has more than 0 in tenths place
        ( stars, halfStar ) =
            if rating - toFloat (floor rating) > 0 then
                ( floor rating, 1 )

            else
                ( floor rating, 0 )

        emptyStars =
            5 - stars - halfStar
    in
    List.concat
        [ List.repeat stars (IonIos.star 24 white)
        , List.repeat halfStar (IonIos.starHalf 24 white)
        , List.repeat emptyStars (IonIos.starOutline 24 white)
        ]


renderSkill : Skill -> Html msg
renderSkill skill =
    div [ class "skill-card full-shadow" ]
        [ h4 [ class "center-text" ] [ text skill.name ]
        , h5 [ class "center-text" ] (skill.rating |> toStars)
        , p [] [ text skill.blurb ]
        ]


renderSkillsPage : SkillsPage -> Html msg
renderSkillsPage skillsPage =
    div [ id "Skills", class "skill-list" ]
        (case skillsPage.skills of
            [] ->
                [ emptyDiv ]

            skills ->
                skills |> List.map renderSkill
        )
