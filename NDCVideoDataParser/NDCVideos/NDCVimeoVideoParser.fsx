#r @".\packages\FSharp.Data\lib\net40\FSharp.Data.dll"
// namespace NDC
module NDCVimeoVideoParser =
    open System
    open FSharp.Data
    open System.IO


    let path file = System.IO.Path.Combine(__SOURCE_DIRECTORY__,"data", file)

    // let videoFiles = ["ndcresp_1.json";"ndcresp_2.json";"ndcresp_3.json";"ndcresp_4.json"]

    type NDC = JsonProvider< @".\data\ndcresp_1.json">

    let nameColumn (x,_,_,_,_) = x
    let uriColumn (_,x,_,_,_) = x
    let descriptionColumn (_,_,x,_,_) = x
    let playsColumn (_,_,_,x,_) = x
    let likesColumn (_,_,_,_,x) = x

    let readFile (file : string) = 
        NDC.Load(file)   

    let parseItems (doc : NDC.Root) = 
        doc.Data
        |> Seq.map (fun x -> (x.Name, x.Uri, x.Description, x.Stats.Plays, x.Metadata.Connections.Likes.Total))

    let readAllFiles files =
        files
        |> Seq.map (fun file -> readFile (path (fst file)) |> parseItems)
        |> Seq.concat   
        |> Seq.sortBy(fun (name,_,_,_,_) -> name)



