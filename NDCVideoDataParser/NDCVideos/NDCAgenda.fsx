﻿#r @".\packages\FSharp.Data\lib\net40\FSharp.Data.dll"
#load "NDCAgendaNameFix.fsx"

// namespace NDC
module NDCAgenda =
    type AgendaInfo = (string*string*string)
    let hello name = sprintf "Hello, %s" name
    let agendaNameColumn (x,_,_) = x
    let agendaSlugsColumn (_,x,_) = x
    let agendaSpeakersColumn (_,_,x) = x

    open System
    open FSharp.Data


    let NDCAgendaDocument =
        // let path = "http://ndcoslo.com/agenda/"
        let path = System.IO.Path.Combine(__SOURCE_DIRECTORY__,"data", "NDCVideosAgenda.html")
        HtmlDocument.Load(path)

    let titles =
        NDCAgendaDocument.CssSelect("div.grid-item.msnry-item > a > div > h2")
        |> List.map(fun a -> a.InnerText())

    let links =
        NDCAgendaDocument.CssSelect("div.grid-item.msnry-item > a")
        |> List.map(fun a -> a.AttributeValue("href"))

    let slugs =
        NDCAgendaDocument.CssSelect("div.grid-item.msnry-item > a")
        |> List.map(fun a -> a.AttributeValue("data-slugs"))

    let speakers =
        NDCAgendaDocument.CssSelect("div.grid-item.msnry-item > a > p ")
        |> List.map(fun a -> a.DirectInnerText())
        |> List.map(fun x -> x.Replace("\r\n", ";"))

    let slugList =
        NDCAgendaDocument.CssSelect("section.tags.boxed-small-list > a")
        |> List.map(fun a -> a.AttributeValue("data-slug"), a.DirectInnerText())
        |> List.sortBy(snd)
        |> List.rev
        |> List.append ["--no match--","Not in agenda"; "","Missing topic"]
        |> List.rev
        |> Seq.toArray


    let listAgenda :AgendaInfo list =
        List.zip3 titles slugs speakers

    let nameEqual (name : string) (elem : AgendaInfo) =
        let matchName = agendaNameColumn elem
        name.StartsWith(matchName)

    let split (separators:char[]) (x:string) = x.Split(separators, StringSplitOptions.RemoveEmptyEntries)

    let uniqueSpeakers =
        speakers
        |> List.map (split [|';'|] >> Seq.toList )
        |> List.concat
        |> List.map (fun x -> x.Trim())
        |> List.distinct
        |> List.sortBy (id)
        |> List.toArray

    let findByNameInList list name  =
        if name = "" then
            None
        else
            List.tryFind (fun item -> nameEqual name item) list


    let findByName name =
        let correctedName = NDCAgendaNameFix.fixNameMismatch name
        findByNameInList listAgenda correctedName


// findByName "Sequential, Concurrent and Parallel Programming" listAgenda;;
// NDCAgenda.uniqueSpeakers;;
// NDCAgenda.speakers;;
// NDCAgenda.slugList;;
