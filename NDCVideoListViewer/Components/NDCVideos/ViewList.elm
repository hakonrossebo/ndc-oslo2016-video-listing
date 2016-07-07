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
  Table.table [ cs "full-width"]
  [
    Table.thead
    [
    ]
    [ Table.tr []
      [ Table.th
        [ ]
        [ text "Title"
        ]
      , Table.th []
        [ text "Slugs"
        ]
      , Table.th []
        [ text "Speakers"
        ]
      , Table.th [Table.sorted Table.Ascending, Table.numeric]
        [ text "Plays"
        ]
      , Table.th [Table.numeric ]
        [ text "Likes"
        ]
      , Table.th [ ]
        [ text "More info"
        ]
      ]
    ]
    , Table.tbody [] ( model.filteredVideos
      |> List.map (\item -> viewVideo item model.mdl ))
  ]
