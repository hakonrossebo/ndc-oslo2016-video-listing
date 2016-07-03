module NDCVideo exposing (view, Model)

import Html exposing (Html, span, strong, em, a, text)
import Html.Attributes exposing (href)
import Material.Table as Table
import String
type alias Model =
  { title : String, url : String, slugs : String, speakers: String, likes: Int, plays: Int }

vimeoUrl : String -> String
vimeoUrl relativePath =
  "https://vimeo.com" ++  String.dropLeft 7 relativePath


view : Model -> Html a
view model =
  Table.tr
  [ ]
    [ Table.td [] [ a [ href (vimeoUrl model.url)][ text model.title]  ]
      , Table.td [] [ text (String.left 20 model.slugs) ]
      , Table.td [] [ text model.speakers ]
    ]
