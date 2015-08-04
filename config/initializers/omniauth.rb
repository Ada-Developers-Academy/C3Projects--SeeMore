Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:first_name, :last_name, :email],
    :uid_field => :last_name,
    :username_field => :first_name,
    :email_field => :email
end
