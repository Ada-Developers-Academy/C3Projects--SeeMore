Rails.application.routes.draw do

  root "feeds#index"

  get "/search_twitter/:username", to: "twitters#search", as: "search_twitter" 



  get "auth/:provider/callback" => 'sessions#create'
  # post is here for OmniAuth developer strategy
  post "auth/:provider/callback" => 'sessions#create'

  # Below allows you to login with developer.
  # Will need routes for each third party you can login through?
  get "auth/:provider" => 'sessions#create', as: 'login'
  delete "logout" => 'sessions#destroy'

  # WIP Instagram API
  resources :instagrams, only: [:index, :new]
  # get "/ig_user", to: "instagrams#search", as: "ig_user"
  get "/oauth/connect" => 'instagrams#connect', as: "ig_connect"
  get "/oauth/callback" => 'instagrams#callback', as: "ig_callback"


end
