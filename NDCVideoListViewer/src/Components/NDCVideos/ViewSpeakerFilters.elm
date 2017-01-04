module NDCVideos.ViewSpeakerFilters exposing (..)

import Html exposing (Html, text, ul, li, div, span, h3, h4, a, button, p)
import Html.Attributes exposing (href, class)
import Html.Events exposing (..)
import List
import NDCVideos.Models exposing (..)
import NDCVideos.Messages exposing (..)


renderSpeakerFilters : Model -> Html Msg
renderSpeakerFilters model =
    if model.toggleSpeakersFilter then
        div []
            [ Html.h5 [] [ text "Filter by speaker:" ]
            , div []
                (List.map
                    (\speaker ->
                        span []
                            [ a [ href "#", onClick (SpeakerFilter (speaker)) ] [ text (speaker) ]
                            , Html.span [] [ text " - " ]
                            ]
                    )
                    model.videoInfo.speakers
                )
            ]
    else
        span [] []
