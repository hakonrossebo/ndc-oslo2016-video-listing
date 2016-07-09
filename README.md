# NDC Oslo 2016 video listing

## Live Site! click this link
# [NDC Oslo 2016 video listing](https://hakonrossebo.github.io/ndc-oslo2016-video-listing/)
## About

NDC Oslo is a great conference and they have shared all their conference talks on Vimeo. Finding the videos you are interested in can be cumbersome. As a learning challenge this summer, I created some F# scripts and a viewer in Elm 
to facilitate a better experience. 

I've used this as a way to learn functional programming with F# and Elm. I would appreciate feedback and contributions on ways to improve this codebase. Other viewer implementations would also be great.

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
* Currently based on elm-mdl, It would be interesting to see other Elm or javascript implementations. 

## Roadmap

There are many things that I had to omit in the first release:

* Search
* Refactor topic and speaker filters to separate components (appreciate contributions)
* More metadata
* Detail view - maybe also with embedded player

## Contributing

I am more than happy to accept external contributions to the project in the form of feedback, bug reports and pull requests.

## Disclaimer
I don't have any connections to NDC Oslo. This is only a personal project. Please notify me on any violations.
---
Thanks for checking this out.

– Håkon Rossebø, [@hakonrossebo](https://twitter.com/hakonrossebo)