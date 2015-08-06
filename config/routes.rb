Rails.application.routes.draw do

  root "feeds#index"

  get "/twitter/:username", to: "twitters#search", as: "search_twitter"
  get "/instagram/:username", to: "instagrams#search", as: "search_instagram"

  get "auth/:provider/callback" => 'sessions#create'
  # post is here for OmniAuth developer strategy
  post "auth/:provider/callback" => 'sessions#create'

  get "auth/:provider" => 'sessions#create', as: 'login'
  delete "logout" => 'sessions#destroy'

  resources :instagrams, only: [:create, :destroy]
  resources :twitters, only: [:create, :destroy]

end
