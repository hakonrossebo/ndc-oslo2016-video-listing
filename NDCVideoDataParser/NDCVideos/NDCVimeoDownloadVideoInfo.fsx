#r @".\packages\FSharp.Data\lib\net40\FSharp.Data.dll"
#load "NDCVideoConfig.fsx"
#load "NDCVideoTokenConfig.fsx"
open System
open System.IO
open FSharp.Data

let GetNDCVimeoVideosResponse uri token page = 
    Http.RequestString
      ( uri, httpMethod = "GET",
        query   = [ "per_page", "50"; "page", page],
        headers = [ "Accept", "application/json"; "Authorization",token ])

let path file = System.IO.Path.Combine(__SOURCE_DIRECTORY__,"data", file)


let writeFile filename contens= 
    File.WriteAllText(filename,contens, Text.Encoding.GetEncoding("ISO-8859-1"))


NDCVideoConfig.videoFiles 
    |> List.map (fun file -> 
        writeFile (path (fst file)) (GetNDCVimeoVideosResponse NDCVideoConfig.vimeoChannelUri NDCVideoTokenConfig.token (snd file))
    );;

