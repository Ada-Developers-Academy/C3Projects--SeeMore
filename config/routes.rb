Rails.application.routes.draw do

  root 'sessions#index'

  get "/auth/:provider/callback", to: "sessions#create"

  get    '/about',           to: 'sessions#show',    as: 'about'
  get    '/auth/:provider',  to: 'sessions#new',     as: 'auth'
  get   '/auth/:provider/callback', to: 'sessions#create', as: 'callback'
  post   '/auth/:provider/callback', to: 'sessions#create' # dev strategy
  delete '/logout',          to: 'sessions#destroy', as: 'logout'

  # TODO: brownie points - add users#show, users#update
  resources :users, only: [:create, :destroy]

  get '/feeds/search',         to: 'feeds#search',         as: 'search'
  post '/search_redirect',     to: 'feeds#search_redirect',as: 'search_redirect'
  get '/results/:search_term', to: 'feeds#search_results', as: 'search_results'
  resources :feeds, except: [:destroy]
end
