# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
  # provider :github, YOUR_CLIENT_ID, YOUR_CLIENT_SECRET
  # provider :instagram, YOUR_CLIENT_ID, YOUR_CLIENT_SECRET
end
