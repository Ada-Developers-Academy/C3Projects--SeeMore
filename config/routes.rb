Rails.application.routes.draw do

  root 'sessions#new'

  get "/auth/:provider/callback", to: "sessions#create"

  get    '/about',           to: 'sessions#show',    as: 'about'
  get    '/auth/:provider',  to: 'sessions#create'
  get    '/login',           to: 'sessions#create',  as: 'login'
  delete '/logout',          to: 'sessions#destroy', as: 'logout'

  # TODO: brownie points - add users#show, users#update
  resources :users, only: [:create, :destroy]

  resources :feeds, except: [:destroy]
  get '/feeds/search',         to: 'feeds#search',         as: 'search'
  get '/feeds/search/results', to: 'feeds#search_results', as: 'search_results'
end
