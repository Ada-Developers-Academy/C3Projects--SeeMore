Rails.application.routes.draw do
  root "feeds#index"

  get "auth/:provider/callback" => 'sessions#create'

  # post is here for OmniAuth developer strategy
  post "auth/:provider/callback" => 'sessions#create'

end
