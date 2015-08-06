Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
  provider :twitter, ENV["TWITTER_API_KEY"], ENV["TWITTER_API_SECRET"]
  provider :vimeo, ENV["VIMEO_CLIENT_ID"], ENV["VIMEO_CLIENT_SECRET"]
  provider :instagram, ENV["INSTAGRAM_CLIENT_ID"], ENV["INSTAGRAM_CLIENT_SECRET"]
end
