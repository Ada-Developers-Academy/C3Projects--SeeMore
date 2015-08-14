module VimeoHelper
  def grab_id(result_hash)
    uri_array = result_hash["uri"].split("/") # "/videos/1234" => ["", "videos", "1234"]
    id_from_uri_array = uri_array.last # "1234"
  end

  def resize_video(result_hash)
    embed_code = result_hash["embed"]["html"]
    embed_code.gsub!(/(width="\d{2,4}")/, 'width="50%"')
    embed_code.gsub!(/(height="\d{2,4}")/, 'height="100%"')
    return embed_code
  end

  def user_already_vimeo?(platform_feed_id)
    feed = Feed.find_by(platform_feed_id: platform_feed_id.to_i, platform: "Vimeo")
    if feed
      return feed.au_users.include? current_user
    else
      return nil
    end
  end
end
