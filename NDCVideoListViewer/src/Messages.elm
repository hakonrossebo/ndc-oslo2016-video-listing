module Messages exposing (..)

import Material
import NDCVideos.Messages exposing (..)


type Msg
    = NDCVideoListMsg NDCVideos.Messages.Msg
    | MDL (Material.Msg Msg)
