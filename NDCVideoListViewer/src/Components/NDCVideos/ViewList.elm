module NDCVideos.ViewList exposing (..)

import Html exposing (Html, text, ul, li, div, span, h3, h4, a, button, p)
import List

import NDCVideos.Models exposing (..)
import NDCVideos.Messages exposing (..)
import NDCVideos.ViewItem exposing (..)
import Material.Table as Table
import Material.Options as Options exposing (cs, css, Style)
  

renderNDCVideos : Model -> Html Msg
renderNDCVideos model =
  Table.table [ css "table-layout" "fixed", css "width" "100%"]
  [
    Table.thead
    [
    ]
    [ Table.tr []
      [ Table.th
        [ css "width" "40%", css "max-width" "200px" ]
        [ text "Title"
        ]
      , Table.th [css "width" "20%"]
        [ text "Slugs"
        ]
      , Table.th [css "width" "10%"]
        [ text "Speakers"
        ]
      , Table.th [css "width" "10%", Table.sorted Table.Descending, Table.numeric, Table.onClick (SortItems PlaysColumn)]
        [ text "Plays"
        ]
      , Table.th [css "width" "10%", Table.sorted Table.Descending, Table.numeric, Table.onClick (SortItems LikesColumn) ]
        [ text "Likes"
        ]
      , Table.th [css "width" "10%" ]
        [ text "More info"
        ]
      ]
    ]
    , Table.tbody [] ( model.filteredVideos
      |> List.map (\item -> viewVideo item model.mdl ))
  ]
