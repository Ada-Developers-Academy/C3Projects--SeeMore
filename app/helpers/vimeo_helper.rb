module VimeoHelper
  def grab_id(result_hash)
    uri_array = result_hash["uri"].split("/") # "/videos/1234" => ["", "videos", "1234"]
    id_from_uri_array = uri_array.last # "1234"
  end

  def resize_video_individual_feed(result_hash)
    embed_code = result_hash["embed"]["html"]
    embed_code.gsub!(/(width="\d{2,4}")/, 'width="50%"')
    embed_code.gsub!(/(height="\d{2,4}")/, 'height="100%"')
    return embed_code
  end

  def resize_video_main_feed(result_hash)
    embed_code = result_hash["content"]
    embed_code.gsub!(/(width="\d{2,4}")/, 'width="50%"')
    embed_code.gsub!(/(height="\d{2,4}")/, 'height="100%"')
    return embed_code
  end
end
