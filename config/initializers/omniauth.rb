Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:first_name, :last_name],
    :uid_field => :last_name,
  provider :instagram, ENV["INSTAGRAM_CLIENT_ID"], ENV["INSTAGRAM_CLIENT_SECRET"]
  provider :vimeo, ENV["VIMEO_CLIENT_ID"], ENV["VIMEO_CLIENT_SECRET"]
end
