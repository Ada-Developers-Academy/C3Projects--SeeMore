Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    fields: [:nickname, :email],
    uid_field: :email

  provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']
end
