module View exposing (..)

import Html.App
import Html exposing (..)
import Html.Attributes exposing (href, class, style)

import Material.Scheme
import Material.Options as Options exposing (css, when)
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
            [ Layout.link
                [ Layout.href "https://github.com/debois/elm-mdl"]
                [ span [] [text "Fork me on Github"] ]]
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
    , main = [ stylesheet, contentview model ]
    }

-- content VIEW
contentview : Model -> Html Msg
contentview model =
  div [ class "elm-app" ]
    [ Html.App.map Messages.NDCVideoListMsg (NDCVideos.View.view model.videoListModel) ]
  |> Material.Scheme.top



stylesheet : Html a
stylesheet =
  Options.stylesheet """
  /* The following line is better done in html. We keep it here for
     compatibility with elm-reactor.
    @import url("assets/styles/github-gist.css");
   */
.full-width {
    width: 100%;
}
.q-width {
    width: 25%;
}
.videoDesc {
    float: left;
    display: inline-block;
    width: 300px;
    max-width: 300px;
    word-wrap: break-word;
    word-break: break-all;
}

"""