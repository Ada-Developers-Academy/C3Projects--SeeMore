module VimeoHelper
  def grab_id(result_hash)
    uri_array = result_hash["uri"].split("/") # "/videos/1234" => ["", "videos", "1234"]
    id_from_uri_array = uri_array.last # "1234"
  end
end
