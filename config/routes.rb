Rails.application.routes.draw do

  root "feeds#index"

  get "/twitter/:username", to: "tweets#search", as: "search_twitter"
  get "/instagram/:username", to: "instagrams#search", as: "search_instagram"
  get "/search", to: "feeds#search", as: "search"
  get "/people", to: "feeds#people", as: "people"

  get "auth/:provider/callback" => 'sessions#create'
  # post is here for OmniAuth developer strategy
  post "auth/:provider/callback" => 'sessions#create'

  get "auth/:provider" => 'sessions#create', as: 'login'
  delete "logout" => 'sessions#destroy'

  resources :instagrams, only: [:create, :destroy]
  resources :tweets, only: [:create, :destroy]

end
