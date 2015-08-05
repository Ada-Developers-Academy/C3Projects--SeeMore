Rails.application.routes.draw do
  post "/auth/developer/callback", to: "sessions#create"
  get "/auth/:provider/callback", to: "sessions#create"

  delete "/logout", to: "sessions#destroy", as: "logout"

  post "/results", to: "instagram#results"
  get "/search", to: "instagram#search"
  get "/feed/:user_id", to: "instagram#individual_feed", as: "feed"
end
