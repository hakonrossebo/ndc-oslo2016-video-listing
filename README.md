# NDC Oslo 2016 video listing

## About

NDC Oslo is a great conference and they have shared all their conference talks on Vimeo. Finding the videos you are interested in can be cumbersome, so I created some F# scripts and a viewer in Elm 
to facilitate a better experience. 

I've used this as a way to learn functional programming with F# and Elm. I would appreciate feedback and contributions on ways to improve this codebase.

### Based on:
* Frontend in [Elm](http://elm-lang.org/)
* F# Scripts

## Requirements
* F#
* Elm

## Vimeo API Token
* note - to use Vimeo API - Create the file NDCVideoTokenConfig.fsx in F# root folder with content:
```bash
module NDCVideoTokenConfig
  let token = "Bearer "your vimeo api token"
```

## Documentation

### F# Scripts
* Downloads NDC Oslo 2016 channel video metadata
* Downloads Agenda html from NDC Oslo site
* Creates a json file to be used by the viewer with no backend

### Elm viewer

## Roadmap

There are many things that I had to omit in the first release:

* Search
* More metadata
* Detail view - maybe also with embedded player

## Contributing

I am more than happy to accept external contributions to the project in the form of feedback, bug reports and pull requests.


---
Thanks for checking this out.

– Håkon Rossebø, [@hakonrossebo](https://twitter.com/hakonrossebo)