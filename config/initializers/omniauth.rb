# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
   provider :developer unless Rails.env.production?
  # provider :github, YOUR_CLIENT_ID, YOUR_CLIENT_SECRET
  provider :instagram, ENV["INSTAGRAM_CLIENT_ID"], ENV["INSTAGRAM_CLIENT_SECRET"]
end

