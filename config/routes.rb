Rails.application.routes.draw do
  # Newsfeed
  root 'home#newsfeed'

  # Signing in and out
  get '/signin', to: 'home#signin', as: 'signin'
  delete 'signout', to: 'sessions#destroy', as: 'signout'

  # OmniAuth callback
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]

  if Rails.env.production?
    get '/auth/developer', to: 'home#fire'
  end

  # Search page
  get '/search', to: 'followees#search', as: 'search'

  # Redirect (checks if search field is filled in)
  post '/instagram_users', to: 'followees#instagram_users_redirect', as: 'instagram_users_redirect'
  post '/twitter_users', to: 'followees#twitter_users_redirect', as: 'twitter_users_redirect'

  # Search Results
  get '/search/:source/:user', to: 'followees#search_results', as: 'search_results'

  # Subscriptions
  resources :subscriptions, only: [:create, :index]
  put '/unsubscribe/:id', to: 'subscriptions#unsubscribe', as: 'unsubscribe'
end
