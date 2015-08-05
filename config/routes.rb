Rails.application.routes.draw do

  root "welcome#index"
  get "/auth/developer", as: "sign_up"
  post "/auth/developer/callback", to: "sessions#create"
  # get "/auth/:provider/callback", to: "sessions#create"

  get "/auth/instagram/callback" => 'sessions#create_instagram'

  get "/auth/vimeo/callback" => 'sessions#create_vimeo'

  delete "/logout", to: "sessions#destroy", as: "logout"

  post "/results", to: "instagram#results"
  get "/search", to: "instagram#search"
  get "/feed/:user_id", to: "instagram#individual_feed", as: "feed"
end
