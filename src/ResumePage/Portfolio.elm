module ResumePage.Portfolio exposing
    ( PortfolioCard(..)
    , PortfolioItem
    , PortfolioPage
    , defaultPortfolio
    , renderPortfolioPage
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Ionicon as Ion
import ResumePage.Helpers exposing (..)


type alias PortfolioPage =
    { items : List PortfolioItem }


type alias PortfolioItem =
    { title : String
    , cards : List PortfolioCard
    }


type PortfolioCard
    = TextCard String (List InfoItem) -- Pure text with title as <ul> with text or links
    | ImageCard String -- Just an image filling the card with capped width/height
    | LinkCard String String -- A card that has just a single link -- entire card is clickable


defaultPortfolio : PortfolioPage
defaultPortfolio =
    { items =
        [ PortfolioItem
            "Verbly"
            [ LinkCard "https://verbly.3digit.dev/" "Verbly"
            , TextCard "Description"
                [ TextItem "Verb conjugation practice"
                , TextItem "Currently supports only Italian"
                , TextItem "Has timed mini-game for practice"
                , TextItem "Has fuzzy-search and reverse search of 500+ verbs"
                ]
            , ImageCard "verbly.png"
            , TextCard "Tech Stack"
                [ TextItem "Backend is Nim exposing REST API"
                , LinkItem "http://nim-lang.org/" "Nim Language"
                , TextItem "Database is SQLite"
                , TextItem "Frontend is in Elm with Materialize CSS"
                , LinkItem "https://elm-lang.org/" "Elm Language"
                , LinkItem "https://materializecss.com/" "Materialize CSS"
                ]
            ]
        ]
    }


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


renderPortfolioPage : PortfolioPage -> Html msg
renderPortfolioPage portfolioPage =
    div [ id "Portfolio" ]
        (case portfolioPage.items of
            [] ->
                [ emptyDiv ]

            items ->
                items |> List.map renderPortfolioItem
        )
