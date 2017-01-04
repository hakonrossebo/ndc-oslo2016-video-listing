module NDCVideos.ViewItem exposing (..)

import Html exposing (Html, text, ul, li, div, span, h3, h4, a, button, p)
import Html.Attributes exposing (href, class)
import String
import NDCVideos.Models exposing (..)
import NDCVideos.Messages exposing (..)
import Material
import Material.Table as Table
import Material.Tooltip as Tooltip
import Material.Icon as Icon
import Material.Options as Options exposing (css, onClick)


vimeoUrl : String -> String
vimeoUrl relativePath =
    "https://vimeo.com" ++ String.dropLeft 7 relativePath


viewVideo : VideoModel -> Material.Model -> Html Msg
viewVideo model outerMdl =
    Table.tr
        []
        [ Table.td [css "text-align" "left"]
            [ a [ href (vimeoUrl model.url), Html.Attributes.target "_blank" ] [ text model.title ]
            , if model.showDescription then
                p [] [ text model.description ]
              else
                span [] []
            ]
        , Table.td [] [ text (String.left 20 model.slugs) ]
        , Table.td [] [ text model.speakers ]
        , Table.td [ Table.numeric ] [ text (toString model.plays) ]
        , Table.td [ Table.numeric ] [ text (toString model.likes) ]
        , Table.td [] [ Icon.view "more" [ Options.onClick (ShowDescription model.url), Tooltip.attach MDL [ 0 ] ], Tooltip.render MDL [ 0 ] outerMdl [ Tooltip.large ] [ text "Show more info" ] ]
        ]
