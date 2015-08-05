Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:first_name, :username, :email],
    :uid_field => :first_name
end
