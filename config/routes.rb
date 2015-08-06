Rails.application.routes.draw do
  root 'posts#index'

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create" # this is required for the OmniAuth Developer Strategy
  # get "/auth/:provider"
  post "/search", to: "searches#index"
  get "search/:search_term", to: "searches#show", as: "search_results"
end
