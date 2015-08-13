Rails.application.config.middleware.use OmniAuth::Builder do
    if !Rails.env.production?
      provider :developer,
        fields: [:name, :email],
        uid_field: :email
    end

  provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']
end
