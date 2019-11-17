module Skills exposing (Skill, renderSkill, toStars)

import Helpers exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ionicon.Ios as IonIos
import List


type alias Skill =
    { name : String
    , rating : Float
    , blurb : String
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
