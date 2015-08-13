Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    fields: [:name, :email],
    uid_field: :email

  provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']
  provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"]

end
