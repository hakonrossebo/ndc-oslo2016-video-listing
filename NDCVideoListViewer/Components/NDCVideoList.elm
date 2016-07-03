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
import Material
import Material.Button as Button
import Material.Table as Table


type alias Model =
  { videos: List NDCVideo.Model
    , filteredVideos: List NDCVideo.Model
    , mdl: Material.Model  }

type alias Mdl = 
  Material.Model 

type Msg
  = NoOp
  | ClearFilters
  | SlugFilter String
  | Fetch
  | FetchSucceed (List NDCVideo.Model)
  | FetchFail Http.Error
  | MDL Material.Msg 

initialModel : Model
initialModel =
  { videos = []
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
    FetchSucceed videoList ->
      ({ model | videos = videoList, filteredVideos = videoList}, Cmd.none)
    ClearFilters ->
      ({ model | filteredVideos = model.videos}, Cmd.none)
    SlugFilter slugfilter ->
      let flt = List.filter (\vid -> String.contains vid.slugs slugfilter) model.videos
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
decodeNDCVideoFetch : Json.Decoder (List NDCVideo.Model)
decodeNDCVideoFetch =
  Json.at ["ndcvideos"] decodeNDCVideoList

-- Then decode the "ndcvideos" key into a List of NDCVideo.Models
decodeNDCVideoList : Json.Decoder (List NDCVideo.Model)
decodeNDCVideoList =
  Json.list decodeNDCVideoData


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
  
slugs : List (String, String)  
slugs = 
  [("net",".NET"),("agile","Agile"),("architecture","Architecture"),("asp-net","ASP.NET"),("big-data","Big Data"),("business-skills","Business Skills"),("c","C"),("c-sharp","C#"),("c-plus-plus","C++"),("cloud","Cloud"),("concurrency","Concurrency"),("continuous-delivery","Continuous Delivery"),("continuous-integration","Continuous Integration"),("craftsmanship","Craftsmanship"),("cross-platform","Cross-Platform"),("database","Database"),("design","Design"),("devops","Devops"),("embedded","Embedded"),("f","F#"),("fun","Fun"),("functional","Functional Programming"),("iot","IoT"),("javascript","JavaScript"),("languages","Languages"),("machine-learning","Machine Learning"),("microservices","Microservices"),("microsoft","Microsoft"),("mobile","Mobile"),("monitoring","Monitoring"),("nosql","NoSQL"),("people","People"),("phyton","Python"),("scalability","Scalability"),("search","Search"),("security","Security"),("testing","Testing"),("tools","Tools"),("ui","UI"),("ux","UX"),("web","Web")]

renderSlugButtons : Model -> Html Msg
renderSlugButtons model =
  div []
      (List.map (\slug -> 
        -- a [onClick (SlugFilter (fst slug))][ text (snd slug)]
        Button.render MDL [0] model.mdl  [Button.raised, Button.colored, Button.onClick (SlugFilter (fst slug))] [ text (snd slug) ]    
          ) slugs )

view : Model -> Html Msg
view model =
  div [ ]
    [ Button.render MDL [0] model.mdl  [Button.raised, Button.colored, Button.onClick (ClearFilters) ] [ text "Clear all filters" ]
    , h4 [][text "Filter by:"]
    , (renderSlugButtons model)
    , div [] [ renderNDCVideos model]
    ]