Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
  provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']
end
