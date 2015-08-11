Rails.application.routes.draw do

  root "feeds#index"

  get "search/twitter" => 'tweets#search'
  post "search/twitter", to: "tweets#search"

  get "search/instagram" => 'instagrams#search'
  post "search/instagram", to: "instagrams#search"

  get "/search", to: "feeds#search", as: "search"
  get "/people", to: "feeds#people", as: "people"

  get "auth/:provider/callback" => 'sessions#create'
  # post is here for OmniAuth developer strategy
  post "auth/:provider/callback" => 'sessions#create'

  get "auth/:provider" => 'sessions#create', as: 'login'
  delete "logout" => 'sessions#destroy'

  resources :instagrams, only: [:create, :destroy]
  resources :tweets, only: [:create, :destroy]
  resources :instagram_posts, only: [:create]
  resources :tweet_posts, only: [:create]

end
