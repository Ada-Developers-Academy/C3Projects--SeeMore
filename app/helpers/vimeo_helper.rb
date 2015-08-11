module VimeoHelper
  def grab_id(result_hash)
    uri_array = result_hash["uri"].split("/") # "/videos/1234" => ["", "videos", "1234"]
    id_from_uri_array = uri_array.last # "1234"
  end

  def resize_video(result_hash)
    embed_code = result_hash["embed"]["html"]
    embed_code.gsub!(/(width="\d{2,4}")/, 'width="100%"')
    embed_code.gsub!(/(height="\d{2,4}")/, 'height="75%"')
    return embed_code
  end
end
