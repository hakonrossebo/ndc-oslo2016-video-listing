module NDCVideos.Update exposing (..)

import String
import Debug
import Http
import Material

import NDCVideos.Models exposing (..)
import NDCVideos.Messages exposing (..)
import NDCVideos.Commands exposing (..)

stringHasItem : String -> String -> String -> Bool
stringHasItem stringWithItems filter split =
  stringWithItems
  |> String.split split
  |> List.member filter


--ACTION
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)
    SortItems column->
      ({model | filteredVideos =
      model.filteredVideos
      |> List.sortBy  
        (case column of
          PlaysColumn ->
            .plays
          LikesColumn ->
            .likes
        )
      |> List.reverse
      }, Cmd.none)
    Fetch ->
      (model, fetchNDCVideos)
    FetchSucceed fetchedInfo ->
      let
        modifiedSlugs = List.append fetchedInfo.slugs [{ slug = "--no match--", name = "Uncategorized" }]
        modifiedInfo = {fetchedInfo | slugs = modifiedSlugs}
      in
      ({ model | videoInfo = modifiedInfo, filteredVideos = modifiedInfo.videos}, Cmd.none)
    ClearFilters ->
      ({ model | filteredVideos = model.videoInfo.videos, currentFilterInfo = "", currentFilterType = "None"}, Cmd.none)
    SlugFilter slugfilter ->
      let flt = List.filter (\vid -> stringHasItem vid.slugs slugfilter ",") model.videoInfo.videos
      in
      ({ model | filteredVideos = flt,currentFilterInfo = "Filtered by topic: " ++ slugfilter, currentFilterType = "Topic"}, Cmd.none)
    SpeakerFilter speakerfilter ->
      let flt = List.filter (\vid -> stringHasItem vid.speakers speakerfilter ";") model.videoInfo.videos
      in
      ({ model | filteredVideos = flt,currentFilterInfo = "Filtered by speaker: " ++ speakerfilter, currentFilterType = "Speaker"}, Cmd.none)
    ToggleSpeakers val ->
      ({model | toggleSpeakersFilter = not model.toggleSpeakersFilter }, Cmd.none)
    ToggleSlugs val ->
      ({model | toggleSlugsFilter = not model.toggleSlugsFilter }, Cmd.none)
    ShowDescription videoUri ->
      ({model | filteredVideos = 
      model.filteredVideos
      |> List.map (\video ->
        if video.url == videoUri then 
          {video | showDescription = True, description = "Not implemented yet due to issue with css. Unable to wrap text."}  
        else
          video )
      }, Cmd.none)
    FetchFail error ->
      case error of
        Http.UnexpectedPayload errorMessage ->
          Debug.log errorMessage
          (model, Cmd.none)
        _ ->
          (model, Cmd.none)
    MDL action' -> 
      Material.update MDL action' model
