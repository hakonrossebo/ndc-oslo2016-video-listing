module NDCVideos.Commands exposing (..)

import NDCVideos.Models exposing (..)
import Slugs.Models exposing (..)
import NDCVideos.Messages exposing (..)

import Http
import Task
import Json.Decode as Json exposing ((:=))


-- HTTP calls
fetchNDCVideos : Cmd Msg
fetchNDCVideos =
  let
    url = "NDCVideos.json"
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeNDCVideoFetch url)

-- Fetch the videos out of the "ndcvideos" key
decodeNDCVideoFetch : Json.Decoder (NDCVideoInfo)
decodeNDCVideoFetch =
      Json.object4 NDCVideoInfo
          ("desc" := Json.string)
          ("ndcvideos" := decodeNDCVideoList)
          ("ndcvideoslugs" := decodeNDCVideoSlugs)
          ("ndcvideospeakers" := decodeNDCVideoSpeakers)

-- Then decode the "ndcvideos" key into a List of NDCVideo.Models
decodeNDCVideoList : Json.Decoder (List VideoModel)
decodeNDCVideoList =
  Json.list decodeNDCVideoData

-- Then decode the "slugs" key into a List of NDCVideoSlug.Models
decodeNDCVideoSlugs : Json.Decoder (List Slugs.Models.Model)
decodeNDCVideoSlugs =
  Json.list decodeNDCVideoSlugData

-- Then decode the "speakers" key into a List of Strings
decodeNDCVideoSpeakers : Json.Decoder (List String)
decodeNDCVideoSpeakers =
  Json.list Json.string


-- Then decode the "slugs" key into a List of NDCVideoSlug.Model
decodeNDCVideoSlugData : Json.Decoder Slugs.Models.Model
decodeNDCVideoSlugData =
  Json.object2 Slugs.Models.Model
    ("slug" := Json.string)
    ("name" := Json.string)

-- Finally, build the decoder for each individual NDCVideo.Model
decodeNDCVideoData : Json.Decoder VideoModel
decodeNDCVideoData =
  Json.object7 VideoModel
    ("title" := Json.string)
    ("description" := Json.string)
    ("url" := Json.string)
    ("slugs" := Json.string)
    ("speakers" := Json.string)
    ("plays" := Json.int)
    ("likes" := Json.int)

