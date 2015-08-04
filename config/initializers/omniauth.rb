module OmniAuth
  module Strategies
    autoload :Developer, Rails.root.join('lib', 'strategies', 'developer')
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer,
    :fields => [:username, :email],
    :uid_field => :email
end
