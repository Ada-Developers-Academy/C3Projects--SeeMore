Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
  provider :instagram, 'INSTAGRAM_CLIENT_ID', 'INSTAGRAM_CLIENT_SECRET' 
end

