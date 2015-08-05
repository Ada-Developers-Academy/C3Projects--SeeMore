Rails.application.routes.draw do

  root 'sessions#new'

  get "/auth/:provider/callback", to: "sessions#create"

  get    '/about',           to: 'sessions#show',    as: 'about'
  get    '/auth/:provider',  to: 'sessions#create'
  get    '/login',           to: 'sessions#create',  as: 'login'
  delete '/logout',          to: 'sessions#destroy', as: 'logout'

  # TODO: brownie points - add users#show, users#update
  resources :users, only: [:create, :destroy]

  get '/feeds/search',         to: 'feeds#search',         as: 'search'
  post '/search_redirect',     to: 'feeds#search_redirect',as: 'search_redirect'
  get '/feeds/search/results', to: 'feeds#search_results', as: 'search_results'
  resources :feeds, except: [:destroy]
end
