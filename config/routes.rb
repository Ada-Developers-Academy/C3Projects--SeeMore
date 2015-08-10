Rails.application.routes.draw do
  root 'posts#index'

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"# this is required for the OmniAuth Developer Strategy

  get "/auth/:provider", to: "sessions#create"
  post "/auth/:provider", to: "sessions#create", as: 'login'

  get "/login", to: "sessions#index", as: 'landing'

  post "/search", to: "searches#search"
  get "search/:client/:search_term", to: "searches#show", as: "search_results"

  get "auth/developer" => 'sessions#create'

  delete "logout" => 'sessions#destroy', as: 'logout'

  get "dashboard/:stalker_id" => "stalkers#index", as: "dashboard"
end
