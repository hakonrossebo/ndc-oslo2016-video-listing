module NDCVideos.Commands exposing (..)

import NDCVideos.Models exposing (..)
import Slugs.Models exposing (..)
import NDCVideos.Messages exposing (..)
import Http
import Json.Decode as Json exposing (field)


-- HTTP calls


fetchNDCVideos : Cmd Msg
fetchNDCVideos =
    let
        url =
            "NDCVideos.json"
    in
        Http.send FetchVideos (Http.get url decodeNDCVideoFetch )



-- Fetch the videos out of the "ndcvideos" key


decodeNDCVideoFetch : Json.Decoder NDCVideoInfo
decodeNDCVideoFetch =
    Json.map5 NDCVideoInfo
        (field "desc" Json.string)
        (field "lastUpdated" Json.string)
        (field "ndcvideos" decodeNDCVideoList)
        (field "ndcvideoslugs" decodeNDCVideoSlugs)
        (field "ndcvideospeakers" decodeNDCVideoSpeakers)



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
    Json.map2 Slugs.Models.Model
        (field "slug" Json.string)
        (field "name" Json.string)



-- Finally, build the decoder for each individual NDCVideo.Model


decodeNDCVideoData : Json.Decoder VideoModel
decodeNDCVideoData =
    Json.map8 VideoModel
        (field "title" Json.string)
        (field "url" Json.string)
        (field "description" Json.string)
        (field "plays" Json.int)
        (field "likes" Json.int)
        (field "slugs" Json.string)
        (field "speakers" Json.string)
        (Json.oneOf
            [ field "showDescription" Json.bool
            , Json.succeed False
            ]
        )
