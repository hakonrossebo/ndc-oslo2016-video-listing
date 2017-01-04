module View exposing (..)

import Html.App
import Html exposing (..)
import Html.Attributes exposing (href, class, style)

import Material.Scheme
import Material.Options as Options exposing (css, when)
import Material.Layout as Layout 
import Material.Scheme as Scheme
import Material.Grid exposing (..)
import Material.Color as Color


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
        [ Layout.title [] [ text "NDC Oslo 2016 Videos" ]
        , Layout.spacer
        , Layout.navigation []
            [ Layout.link
                [ Layout.href "https://github.com/hakonrossebo/ndc-oslo2016-video-listing"]
                [ span [] [text "Fork me on Github"] ]]
        ]
    ]
  else
    []


boxed : List (Options.Property a b)
boxed = 
  [ css "margin" "auto" 
  , css "padding-top" "8px" 
  , css "padding-left" "4%" 
  , css "padding-right" "4%" 
  ]


background : Color.Color
background =
  Color.color Color.Yellow Color.S50 


body' : Html a -> Html a 
body' contents = 
  Options.div
    boxed
    [ grid [ noSpacing ]
       [ cell [ size All 12, size Phone 4 ] [ contents ]
       , cell 
           [ size All 5, offset Desktop 1, size Phone 4, align Top 
           , css "position" "relative" 
           ] 
           []
       ]
    , Options.div 
      [ css "margin-bottom" "48px"
      ][]
    ]


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
  |> body'



stylesheet : Html a
stylesheet =
  Options.stylesheet """
  /* The following line is better done in html. We keep it here for
     compatibility with elm-reactor.
    @import url("assets/styles/github-gist.css");
   */
.myTable {
    width: 100%;
    table-layout: fixed;
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
.wrapword{
white-space: -moz-pre-wrap !important;  /* Mozilla, since 1999 */
white-space: -webkit-pre-wrap; /*Chrome & Safari */ 
white-space: -pre-wrap;      /* Opera 4-6 */
white-space: -o-pre-wrap;    /* Opera 7 */
white-space: pre-wrap;       /* css-3 */
word-wrap: break-word;       /* Internet Explorer 5.5+ */
white-space: normal;
}

"""