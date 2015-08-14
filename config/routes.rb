Rails.application.routes.draw do

  root "feeds#index"

  get "search/twitter" => 'tweets#search'
  post "search/twitter", to: "tweets#search"

  get "search/instagram" => 'instagrams#search'
  post "search/instagram", to: "instagrams#search"

  get "/search", to: "feeds#search", as: "search"
  get "/people", to: "feeds#people", as: "people"


  get "auth/developer" => "feeds#nope" if Rails.env.production?

  get "auth/:provider/callback" => 'sessions#create'
  # post is here for OmniAuth developer strategy
  post "auth/:provider/callback" => 'sessions#create'

  get "auth/:provider" => 'sessions#create', as: 'login'
  delete "logout" => 'sessions#destroy'

  resources :instagrams, only: [:create, :destroy]
  resources :tweets, only: [:create, :destroy]

  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

end
