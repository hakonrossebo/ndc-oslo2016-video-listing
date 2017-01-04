module NDCVideos.Messages exposing (..)

import Http
import Material
import NDCVideos.Models exposing (..)


type Msg
    = NoOp
    | ClearFilters
    | SortItems SortColumn
    | SlugFilter String
    | SpeakerFilter String
    | ToggleSpeakers Int
    | ToggleSlugs Int
    | ShowDescription String
    | Fetch
    | FetchVideos (Result Http.Error NDCVideoInfo)
    | MDL (Material.Msg Msg)
