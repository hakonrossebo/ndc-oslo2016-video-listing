module NDCVideos.View exposing (..)

import Html exposing (Html, text, ul, li, div, span, h3, h4, a, button, p)
import NDCVideos.Models exposing (..)
import NDCVideos.Messages exposing (..)
import NDCVideos.ViewSlugFilters exposing (..)
import NDCVideos.ViewSpeakerFilters exposing (..)
import NDCVideos.ViewList exposing (..)
import Material.Button as Button
import Material.Toggles as Toggles
import Material.Options as Options exposing (onToggle)

renderSlugsToggle : Model -> Html Msg
renderSlugsToggle model =
    Toggles.switch MDL
        [ 0 ]
        model.mdl
        [ Options.onToggle (ToggleSlugs 0)
        , Toggles.value model.toggleSlugsFilter
        ]
        [ text "Show topic filters" ]


renderSpeakersToggle : Model -> Html Msg
renderSpeakersToggle model =
    Toggles.switch MDL
        [ 1 ]
        model.mdl
        [ Options.onToggle (ToggleSpeakers 0)
        , Toggles.value model.toggleSpeakersFilter
        ]
        [ text "Show speaker filters" ]


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text "NDC Oslo is a great conference and they have shared all their conference talks on Vimeo. Finding the videos you are interested in can be cumbersome. As a learning challenge this summer, I created some F# scripts and a viewer in Elm \nto facilitate a better experience. I've used this as a way to learn functional programming with F# and Elm. I would appreciate feedback and contributions on ways to improve this codebase. Other viewer implementations would also be great." ]
        , p [] [ text ("Vimeo data last updated: " ++ model.videoInfo.lastUpdated) ]
        , (renderSlugsToggle model)
        , (renderSpeakersToggle model)
        , (renderSlugFilters model)
        , (renderSpeakerFilters model)
        , if model.currentFilterType /= "None" then
              Button.render MDL [ 0 ] model.mdl [ Button.raised, Button.colored, Options.onClick (ClearFilters) ] [ text "Clear all filters" ]
          else
            Html.span [] []
        , Html.h5 [] [ text model.currentFilterInfo ]
        , div [] [ renderNDCVideos model ]
        ]
