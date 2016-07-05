module NDCVideoSlug exposing (view, Model)

import Html exposing (Html, span, strong, em, a, text, div)
import Html.Attributes exposing (href)
import Material.Table as Table
import String

type alias Model = 
  -- (String, String)
  { slug : String, name : String }



view : Model -> Html a
view model =
  div [][]