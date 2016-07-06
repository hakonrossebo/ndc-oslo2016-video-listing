module NDCVideos.View exposing (..)

import Html exposing (Html, text, ul, li, div, span, h3, h4, a, button)
import Html.Attributes exposing (href)
import Html.Events exposing (..)
import List
import String

import NDCVideos.Models exposing (..)
import NDCVideos.Messages exposing (..)
import Material.Button as Button
import Material.Table as Table
import Material.Toggles as Toggles

renderNDCVideos : Model -> Html a
renderNDCVideos model =
  Table.table []
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
      ]
    ]
    , Table.tbody [] ( model.filteredVideos
      |> List.map (\item -> viewVideo item ))
  ]
  
renderSlugFilters : Model -> Html Msg
renderSlugFilters model =
  if model.toggleSlugsFilter then 
    div []
    [
      Html.h5 [][text "Filter by topic:"]
      , div []
          (List.map (\slug -> 
            span[]
            [
              a [href "#", onClick (SlugFilter (slug.slug))][ text (slug.name)],
              Html.span [][ text " - "]
            ]
            -- Button.render MDL [0] model.mdl  [Button.minifab, Button.colored, Button.onClick (SlugFilter (slug.slug))] [ text (slug.name) ]    
              ) model.videoInfo.slugs )
    ]
  else
    span [][]

renderSpeakerFilters : Model -> Html Msg
renderSpeakerFilters model =
  if model.toggleSpeakersFilter then 
    div []
    [
      Html.h5 [][text "Filter by speaker:"]
      , div []
          (List.map (\speaker -> 
            span[]
            [
              a [href "#", onClick (SpeakerFilter (speaker))][ text (speaker)],
              Html.span [][ text " - "]
            ]
              ) model.videoInfo.speakers )
    ]
  else
    span [][]

renderSlugsToggle : Model -> Html Msg
renderSlugsToggle model =
  Toggles.switch MDL [0] model.mdl
    [ Toggles.onClick (ToggleSlugs 0), Toggles.value model.toggleSlugsFilter
    ]
    [ text "Show topic filters" ]  

renderSpeakersToggle : Model -> Html Msg
renderSpeakersToggle model =
  Toggles.switch MDL [0] model.mdl
    [ Toggles.onClick (ToggleSpeakers 0), Toggles.value model.toggleSpeakersFilter
    ]
    [ text "Show speaker filters" ]  


vimeoUrl : String -> String
vimeoUrl relativePath =
  "https://vimeo.com" ++  String.dropLeft 7 relativePath


viewVideo : VideoModel -> Html a
viewVideo model =
  Table.tr
  [ ]
    [ Table.td [] [ a [ href (vimeoUrl model.url)][ text model.title]  ]
      , Table.td [] [ text (String.left 20 model.slugs) ]
      , Table.td [] [ text model.speakers ]
    ]


view : Model -> Html Msg
view model =
  div [ ]
    [ (renderSlugsToggle model)
    , (renderSpeakersToggle model)
    , (renderSlugFilters model)
    , (renderSpeakerFilters model)
    , if model.currentFilterType /= "None" then Button.render MDL [0] model.mdl  [Button.raised, Button.colored, Button.onClick (ClearFilters) ] [ text "Clear all filters" ] else Html.span [][]
    , Html.h5 [][text model.currentFilterInfo]
    , div [] [ renderNDCVideos model]
    ]