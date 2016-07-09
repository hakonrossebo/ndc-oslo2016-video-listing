module NDCVideos.ViewSlugFilters exposing (..)

import Html exposing (Html, text, ul, li, div, span, h3, h4, a, button, p)
import Html.Attributes exposing (href, class)
import Html.Events exposing (..)
import List

import NDCVideos.Models exposing (..)
import NDCVideos.Messages exposing (..)


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
