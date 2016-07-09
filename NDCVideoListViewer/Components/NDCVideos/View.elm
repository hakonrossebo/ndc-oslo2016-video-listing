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
    [ p [][ text "NDC Oslo is a great conference and they have shared all their conference talks on Vimeo. Finding the videos you are interested in can be cumbersome, so I created some F# scripts and a viewer in Elm 
to facilitate a better experience. 

I've used this as a way to learn functional programming with F# and Elm. I would appreciate feedback on ways to improve this codebase."]
    , (renderSlugsToggle model)
    , (renderSpeakersToggle model)
    , (renderSlugFilters model)
    , (renderSpeakerFilters model)
    , if model.currentFilterType /= "None" then Button.render MDL [0] model.mdl  [Button.raised, Button.colored, Button.onClick (ClearFilters) ] [ text "Clear all filters" ] else Html.span [][]
    , Html.h5 [][text model.currentFilterInfo]
    , div [] [ renderNDCVideos model]
    ]