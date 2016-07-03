import Html.App
import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Platform.Cmd exposing (Cmd)

import Material
import Material.Scheme
import Material.Button as Button
import Material.Table as Table
import Material.Helpers exposing (pure, lift, lift')
import Material.Options exposing (css, when)
import Material.Layout as Layout 
import Material.Icon as Icon
import Material.Scheme as Scheme
import Components.NDCVideoList as NDCVideoList

-- MODEL
type alias Mdl =
  Material.Model

type alias Model =
  { videoListModel : NDCVideoList.Model
  , mdl : Material.Model
  , transparentHeader : Bool
  }

type Msg
  = NDCVideoListMsg NDCVideoList.Msg
  | MDL Material.Msg

model : Model
model =
  { videoListModel = NDCVideoList.initialModel
  , mdl = Material.model
  , transparentHeader = True
  }

init : (Model, Cmd Msg)
init =
  ( model, Cmd.map NDCVideoListMsg NDCVideoList.fetchNDCVideos )

-- ACTION, UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NDCVideoListMsg videoMsg ->
      let (updatedModel, cmd) = NDCVideoList.update videoMsg model.videoListModel
      in ( { model | videoListModel = updatedModel }, Cmd.map NDCVideoListMsg cmd )
    MDL action' -> 
          Material.update MDL action' model

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

drawer : List (Html Msg)
drawer = []
  -- [ Layout.title [] [ text "Example drawer" ]
  -- , Layout.navigation
  --   [] 
  --   [  Layout.link
  --       [ Layout.href "https://github.com/debois/elm-mdl" ]
  --       [ text "github" ]
  --   , Layout.link
  --       [ Layout.href "http://package.elm-lang.org/packages/debois/elm-mdl/latest/" ]
  --       [ text "elm-package" ]
  --   ]
  -- ]


header : Model -> List (Html Msg)
header model =
  if True then 
    [ Layout.row 
        [ --css "height" "192px" 
        -- , css "transition" "height 333ms ease-in-out 0s"
        -- [ if model.transparentHeader then css "height" "192px" else Options.nop 
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
  Layout.render MDL model.mdl
    [ Layout.fixedHeader
    
    ]
    { header = header model
    , drawer = drawer
    , tabs = ([], [])
    , main = [ contentview model ]
    -- { header = myHeader
    -- , drawer = myDrawer
    -- , tabs = (tabTitles, [])
    -- , main = [ contentview model ]
    }
  -- div [ class "elm-app" ]
  --   [ Html.App.map NDCVideoListMsg (NDCVideoList.view model.videoListModel) ]
  -- |> Material.Scheme.top


-- content VIEW
contentview : Model -> Html Msg
contentview model =
  div [ class "elm-app" ]
    [ Html.App.map NDCVideoListMsg (NDCVideoList.view model.videoListModel) ]
  |> Material.Scheme.top


main : Program Never
main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
