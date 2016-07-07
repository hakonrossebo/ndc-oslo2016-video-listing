module NDCVideos.View exposing (..)

import Html exposing (Html, text, ul, li, div, span, h3, h4, a, button, p)

import NDCVideos.Models exposing (..)
import NDCVideos.Messages exposing (..)
import NDCVideos.ViewSlugFilters exposing (..)
import NDCVideos.ViewSpeakerFilters exposing (..)
import NDCVideos.ViewList exposing (..)

import Material.Button as Button
import Material.Toggles as Toggles

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