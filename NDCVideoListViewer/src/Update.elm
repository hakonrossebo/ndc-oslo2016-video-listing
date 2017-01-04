module Update exposing (..)

import Material
import Messages exposing (Msg(..))
import Models exposing (Model)
import NDCVideos.Update


-- ACTION, UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NDCVideoListMsg videoMsg ->
            let
                ( updatedModel, cmd ) =
                    NDCVideos.Update.update videoMsg model.videoListModel
            in
                ( { model | videoListModel = updatedModel }, Cmd.map NDCVideoListMsg cmd )

        MDL action_ ->
            Material.update MDL action_ model
