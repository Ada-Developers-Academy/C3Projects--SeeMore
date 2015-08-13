Rails.application.routes.draw do

  root 'sessions#index'

  get    '/auth/:provider',  to: 'sessions#new',     as: 'auth'
  get    '/auth/:provider/callback', to: 'sessions#create', as: 'callback'
  post   '/auth/:provider/callback', to: 'sessions#create' # dev strategy
  get    '/about',           to: 'sessions#show',    as: 'about'
  delete '/logout',          to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:create, :destroy]

  resources :feeds, except: [:show, :destroy]
  get  '/feeds/dismiss_alert',    to: 'feeds#dismiss_alert',   as: 'dismiss_alert'
  post '/feeds/dismiss_alert',    to: 'feeds#dismiss_alert'
  get  '/feeds/:provider/search', to: 'feeds#search',          as: 'search'
  post '/search_redirect',        to: 'feeds#search_redirect', as: 'search_redirect'
  get  '/results/:search_term',   to: 'feeds#search_results',  as: 'search_results'


  post '/tw_follow/:tw_user',      to: 'feeds#tw_follow',      as: 'tw_follow'

  get '/instagram_follow',        to: 'feeds#ig_follow' #fake
  post '/instagram_follow',       to: 'feeds#ig_follow',       as:  'ig_follow'

end
