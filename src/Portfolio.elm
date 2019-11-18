module Portfolio exposing (PortfolioCard(..), PortfolioItem, renderPortfolioItem)

import Helpers exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Ionicon as Ion



-- Portfolio Item


type alias PortfolioItem =
    { title : String
    , cards : List PortfolioCard
    }


type PortfolioCard
    = TextCard String (List InfoItem) -- Pure text with title as <ul> with text or links
    | ImageCard String -- Just an image filling the card with capped width/height
    | LinkCard String String -- A card that has just a single link -- entire card is clickable


renderCardGroup : List PortfolioCard -> Html msg
renderCardGroup cardGroup =
    div [ class "folio-cards" ]
        (List.map
            (\card ->
                case card of
                    TextCard title items ->
                        div []
                            [ h6 [ class "folio-em center-text" ] [ text title ]
                            , ul [ class "folio-card" ] (renderInfoList items)
                            ]

                    ImageCard imgPath ->
                        div [ class "folio-image" ]
                            [ img [ src imgPath ] [] ]

                    LinkCard url txt ->
                        div [ class "center-text folio-link" ]
                            [ a [ href url ]
                                [ div []
                                    [ Ion.link 40 white
                                    , h3 [] [ text txt ]
                                    ]
                                ]
                            ]
            )
            cardGroup
        )


renderPortfolioItem : PortfolioItem -> Html msg
renderPortfolioItem item =
    div [ class "folio-item full-shadow" ]
        [ div []
            [ div
                [ class "folio-title center-text" ]
                [ h2 [] [ text item.title ] ]
            ]
        , renderCardGroup item.cards
        ]
