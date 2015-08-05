Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    fields: [:name, :email],
    uid_field: :email
end
