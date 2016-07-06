module Models exposing (..)

import Material
import NDCVideos.Models exposing (..)

-- MODEL
type alias Mdl =
  Material.Model

type alias Model =
  { videoListModel : NDCVideos.Models.Model
  , mdl : Material.Model
  , transparentHeader : Bool
  }
