Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:first_name, :last_name],
    :uid_field => :last_name
end
