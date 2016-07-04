module NDCVideoConfig

  let videoFiles = [("ndcresp_1.json","1");("ndcresp_2.json","2");("ndcresp_3.json","3");("ndcresp_4.json","4")]
  let vimeoChannelUri = "https://api.vimeo.com/channels/ndcoslo2016/videos"
  let outputJsonName = "NDCVideos.json"
  [<Literal>]
  let ndcJsonSchema = 
      """
      {
          "desc": "desc123",
          "ndcvideos":
              [
                  {
                      "title": "test",
                      "url": "test",
                      "description": "desc",
                      "plays": 1,
                      "likes": 1,
                      "slugs": "slugs",
                      "speakers": "speakers"
                  }
              ],
          "ndcvideoslugs":
              [
                  {
                      "slug": "test",
                      "name": "test"
                  }
              ],
          "ndcvideospeakers":
              ["somestring1", "somestring2"]
      }
      """