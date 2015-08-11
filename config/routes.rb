Rails.application.routes.draw do
  root 'posts#index'

  if Rails.env.development?
    post "/auth/:provider/callback", to: "sessions#create"# this is required for the OmniAuth Developer Strategy
    get "auth/developer" => 'sessions#create'
  end

  get "/auth/:provider", to: "sessions#create"
  post "/auth/:provider", to: "sessions#create", as: 'login'
  get "/auth/:provider/callback", to: "sessions#create"

  get "/login", to: "sessions#index", as: 'landing'
  delete "logout" => 'sessions#destroy', as: 'logout'

  get "dashboard/:stalker_id" => "stalkers#index", as: "dashboard"

  post "/search", to: "searches#search"
  get "search/:client/:search_term", to: "searches#show", as: "search_results"

  post "/follow" => 'prey#create', as: 'follow'
  patch "/unfollow", to: "prey#unfollow", as: "unfollow"
end
