#r @".\packages\FSharp.Data\lib\net40\FSharp.Data.dll"
#load "NDCVideoConfig.fsx"
#load "NDCAgenda.fsx"
#load "NDCVimeoVideoParser.fsx"
open NDCAgenda
open NDCVimeoVideoParser
open NDCVideoConfig
open FSharp.Data
open System.IO

type NdcVideos = JsonProvider<NDCVideoConfig.NdcJsonSchema, RootName="ndc">

let combinedNameColumn (x,_,_,_,_,_,_) = x
let combinedUriColumn (_,x,_,_,_,_,_) = x
let combinedDescriptionColumn (_,_,x,_,_,_,_) = x
let combinedPlaysColumn (_,_,_,x,_,_,_) = x
let combinedLikesColumn (_,_,_,_,x,_,_) = x
let combindedAgendaSlugsColumn (_,_,_,_,_,x,_) = x
let combinedAgendaSpeakersColumn (_,_,_,_,_,_,x) = x

let combinedNDCVideoData parsedVideos findByName =
    parsedVideos
    |> Seq.map (fun x -> match findByName (NDCVimeoVideoParser.nameColumn x)  with
                            | Some i -> (NDCVimeoVideoParser.nameColumn x, NDCVimeoVideoParser.uriColumn x, NDCVimeoVideoParser.descriptionColumn x, NDCVimeoVideoParser.playsColumn x, NDCVimeoVideoParser.likesColumn x, NDCAgenda.agendaSlugsColumn i, NDCAgenda.agendaSpeakersColumn i)
                            | None -> (NDCVimeoVideoParser.nameColumn x, NDCVimeoVideoParser.uriColumn x, NDCVimeoVideoParser.descriptionColumn x, NDCVimeoVideoParser.playsColumn x, NDCVimeoVideoParser.likesColumn x, "--no match--", "--no match--"))

let jsonMovieData parsedVideos findByName=
    combinedNDCVideoData parsedVideos findByName
    |> Seq.map (fun x -> NdcVideos.Ndcvideo(combinedNameColumn x, combinedUriColumn x, combinedDescriptionColumn x, combinedPlaysColumn x, combinedLikesColumn x, combindedAgendaSlugsColumn x, combinedAgendaSpeakersColumn x))
    |> Seq.toArray

let jsonMovieSlugData slugList =
    slugList
    |> Seq.map (fun x -> NdcVideos.Ndcvideoslug(fst x, snd x))
    |> Seq.toArray

let newNDCVideos parsedVideos findByName slugList uniqueSpeakers=
    NdcVideos.Ndc (desc= "NDCOslo2016 Videos", lastUpdated = System.DateTime.Now.ToShortDateString(), ndcvideos=jsonMovieData parsedVideos findByName, ndcvideoslugs=jsonMovieSlugData slugList, ndcvideospeakers=uniqueSpeakers )

let path file = System.IO.Path.Combine(__SOURCE_DIRECTORY__,"data", file)

let writeNDCVideoJson fileReader videoList findByName slugList uniqueSpeakers =
    let parsedVideos = fileReader videoList
    let fileWriter = new StreamWriter(path NDCVideoConfig.outputJsonName)
    let combinedVideoData = newNDCVideos parsedVideos findByName slugList uniqueSpeakers
    combinedVideoData.JsonValue.WriteTo(fileWriter, JsonSaveOptions.None);
    fileWriter.Close();

writeNDCVideoJson NDCVimeoVideoParser.readAllFiles NDCVideoConfig.videoFiles NDCAgenda.findByName NDCAgenda.slugList NDCAgenda.uniqueSpeakers;;
