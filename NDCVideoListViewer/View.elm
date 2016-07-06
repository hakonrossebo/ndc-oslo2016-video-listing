module View exposing (..)

import Html.App
import Html exposing (..)
import Html.Attributes exposing (href, class, style)

import Material.Scheme
import Material.Options exposing (css, when)
import Material.Layout as Layout 
import Material.Scheme as Scheme

import Messages exposing (Msg)
import Models exposing (Model)
import NDCVideos.View

drawer : List (Html Msg)
drawer = []

header : Model -> List (Html Msg)
header model =
  if True then 
    [ Layout.row 
        [  
          css "transition" "height 333ms ease-in-out 0s"
        ]
        [ Layout.title [] [ text "NDC 2016 Videos" ]
        , Layout.spacer
        , Layout.navigation []
            [ ]
        ]
    ]
  else
    []


-- VIEW
view : Model -> Html Msg
view model =
  Layout.render Messages.MDL model.mdl
    [ Layout.fixedHeader
    
    ]
    { header = header model
    , drawer = drawer
    , tabs = ([], [])
    , main = [ contentview model ]
    }

-- content VIEW
contentview : Model -> Html Msg
contentview model =
  div [ class "elm-app" ]
    [ Html.App.map Messages.NDCVideoListMsg (NDCVideos.View.view model.videoListModel) ]
  |> Material.Scheme.top
