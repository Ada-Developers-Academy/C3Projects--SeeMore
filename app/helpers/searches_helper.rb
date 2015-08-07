module SearchesHelper
  def large_image_url(prey)
    prey.profile_image_url.to_s.sub! '_normal', ''
  end
end
