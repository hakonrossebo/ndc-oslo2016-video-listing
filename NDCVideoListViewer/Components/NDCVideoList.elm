module Components.NDCVideoList exposing (..)

import Html exposing (Html, text, ul, li, div, h2, h3, h4, a, button)
import Html.Attributes exposing (href)
import Http
import Task
import Json.Decode as Json exposing ((:=))
import Debug
import List
import String
import NDCVideo
import NDCVideoSlug
import Material
import Material.Button as Button
import Material.Table as Table

type alias NDCVideoInfo =
  { name : String
  , videos : List NDCVideo.Model
  , slugs : List NDCVideoSlug.Model
  , speakers : List String
  }

type alias Model =
  {   videoInfo: NDCVideoInfo
    , filteredVideos: List NDCVideo.Model
    , mdl: Material.Model  }

type alias Mdl = 
  Material.Model 

type Msg
  = NoOp
  | ClearFilters
  | SlugFilter String
  | Fetch
  | FetchSucceed (NDCVideoInfo)
  | FetchFail Http.Error
  | MDL Material.Msg 

initialModel : Model
initialModel =
  { videoInfo = {name="", videos=[], slugs=[], speakers=[]}
  , filteredVideos = []
  , mdl = Material.model }


--ACTION
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)
    Fetch ->
      (model, fetchNDCVideos)
    FetchSucceed fetchedInfo ->
      ({ model | videoInfo = fetchedInfo, filteredVideos = fetchedInfo.videos}, Cmd.none)
    ClearFilters ->
      ({ model | filteredVideos = model.videoInfo.videos}, Cmd.none)
    SlugFilter slugfilter ->
      let flt = List.filter (\vid -> String.contains vid.slugs slugfilter) model.videoInfo.videos
      in
      ({ model | filteredVideos = flt}, Cmd.none)
    FetchFail error ->
      case error of
        Http.UnexpectedPayload errorMessage ->
          Debug.log errorMessage
          (model, Cmd.none)
        _ ->
          (model, Cmd.none)
    MDL action' -> 
      Material.update MDL action' model
      
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
decodeNDCVideoList : Json.Decoder (List NDCVideo.Model)
decodeNDCVideoList =
  Json.list decodeNDCVideoData

-- Then decode the "slugs" key into a List of NDCVideoSlug.Models
decodeNDCVideoSlugs : Json.Decoder (List NDCVideoSlug.Model)
decodeNDCVideoSlugs =
  Json.list decodeNDCVideoSlugData

-- Then decode the "speakers" key into a List of Strings
decodeNDCVideoSpeakers : Json.Decoder (List String)
decodeNDCVideoSpeakers =
  Json.list Json.string


-- Then decode the "slugs" key into a List of NDCVideoSlug.Model
decodeNDCVideoSlugData : Json.Decoder NDCVideoSlug.Model
decodeNDCVideoSlugData =
  Json.object2 NDCVideoSlug.Model
    ("slug" := Json.string)
    ("name" := Json.string)

-- Finally, build the decoder for each individual NDCVideo.Model
decodeNDCVideoData : Json.Decoder NDCVideo.Model
decodeNDCVideoData =
  Json.object6 NDCVideo.Model
    ("title" := Json.string)
    ("url" := Json.string)
    ("slugs" := Json.string)
    ("speakers" := Json.string)
    ("plays" := Json.int)
    ("likes" := Json.int)


renderNDCVideos : Model -> Html a
renderNDCVideos model =
  Table.table []
  [
    Table.thead
    [
    ]
    [ Table.tr []
      [ Table.th
        [ ]
        [ text "Title"
        ]
      , Table.th []
        [ text "Slugs"
        ]
      , Table.th []
        [ text "Speakers"
        ]
      ]
    ]
    , Table.tbody [] ( model.filteredVideos
      |> List.map (\item -> NDCVideo.view item ))
  ]
  
renderSlugButtons : Model -> Html Msg
renderSlugButtons model =
  div []
      (List.map (\slug -> 
        -- a [onClick (SlugFilter (fst slug))][ text (snd slug)]
        Button.render MDL [0] model.mdl  [Button.raised, Button.colored, Button.onClick (SlugFilter (slug.slug))] [ text (slug.name) ]    
          ) model.videoInfo.slugs )

renderSpeakers : Model -> Html Msg
renderSpeakers model =
  div []
      (List.map (\speaker -> 
        a [][ text (speaker)]
          ) model.videoInfo.speakers )

view : Model -> Html Msg
view model =
  div [ ]
    [ Button.render MDL [0] model.mdl  [Button.raised, Button.colored, Button.onClick (ClearFilters) ] [ text "Clear all filters" ]
    , h4 [][text "Filter by:"]
    , (renderSlugButtons model)
    , (renderSpeakers model)
    , div [][ text model.videoInfo.name]
    , div [] [ renderNDCVideos model]
    ]