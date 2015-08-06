Rails.application.routes.draw do

  root "feeds#index"

  get "auth/:provider/callback" => 'sessions#create'
  post "auth/:provider/callback" => 'sessions#create'

  # Below allows you to login with developer.
  # Will need routes for each third party you can login through?
  get "auth/:provider" => 'sessions#create', as: 'login'

  delete "logout" => 'sessions#destroy'
  # post is here for OmniAuth developer strategy

  # get "/ig_user", to: "instagrams#search", as: "ig_user"

  resources :instagrams, only: [:index]

end
