module NDCVideos.Models exposing (..)

import Material
import Slugs.Models exposing (..)

type alias VideoModel =
  { title : String, url : String, description : String, plays: Int, likes: Int, slugs : String, speakers: String, showDescription : Bool }


type alias NDCVideoInfo =
  { name : String
  , videos : List VideoModel
  , slugs : List Slugs.Models.Model
  , speakers : List String
  }

type alias Model =
  {   videoInfo: NDCVideoInfo
    , filteredVideos: List VideoModel
    , currentFilterInfo : String 
    , currentFilterType : String
    , toggleSlugsFilter : Bool
    , toggleSpeakersFilter : Bool 
    , mdl: Material.Model  }

type alias Mdl = 
  Material.Model 

type SortColumn
    = PlaysColumn
    | LikesColumn

initialModel : Model
initialModel =
  { videoInfo = {name="", videos=[], slugs=[], speakers=[]}
  , filteredVideos = []
  , currentFilterInfo = "Showing all videos"
  , currentFilterType = "None"
  , toggleSlugsFilter = False
  , toggleSpeakersFilter = False
  , mdl = Material.model }

