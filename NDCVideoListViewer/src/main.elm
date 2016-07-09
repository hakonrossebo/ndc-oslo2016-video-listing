import Html.App
import Material

import Models exposing (..)
import Messages exposing (Msg(..))
import Update exposing (update)
import View exposing (view)

import NDCVideos.Models exposing (initialModel)
import NDCVideos.Commands exposing (..)


initialmodel : Model
initialmodel =
  { videoListModel = NDCVideos.Models.initialModel
  , mdl = Material.model
  , transparentHeader = True
  }

init : (Model, Cmd Msg)
init =
  ( initialmodel, Cmd.map NDCVideoListMsg fetchNDCVideos )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


main : Program Never
main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
