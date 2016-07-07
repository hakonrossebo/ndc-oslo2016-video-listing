module NDCVideos.Messages exposing (..)

import Http
import Material
import NDCVideos.Models exposing (..)

type Msg
  = NoOp
  | ClearFilters
  | SlugFilter String
  | SpeakerFilter String
  | ToggleSpeakers Int
  | ToggleSlugs Int
  | ShowDescription String
  | Fetch
  | FetchSucceed (NDCVideoInfo)
  | FetchFail Http.Error
  | MDL Material.Msg 
