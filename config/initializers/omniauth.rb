# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
   provider :developer unless Rails.env.production?
  # provider :twitter, ENV["TWITTER_CLIENT_ID"], ENV["TWITTER_CLIENT_SECRET"]
  provider :instagram, ENV["INSTAGRAM_CLIENT_ID"], ENV["INSTAGRAM_CLIENT_SECRET"]
end
