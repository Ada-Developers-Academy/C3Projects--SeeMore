Rails.application.routes.draw do
  root 'home#newsfeed'

  get '/signin', to: 'home#signin', as: 'signin'

  match "/auth/:provider/callback", to: "sessions#create", via: [:get, :post]


  # Search page
  get '/search', to: 'followees#search', as: "search"
  
  # Redirect (checks if search field is filled in)
  post "/instagram_users", to: "followees#instagram_users_redirect", as: "instagram_users_redirect"
  post '/twitter_users', to: 'followees#twitter_users_redirect', as: 'twitter_users_redirect'

  # Search Results
  get '/search/:source/:user', to: "followees#search_results", as: "search_results"

  resources :subscription

  post "/unsubscribe/:id", to: "subscriptions#unsubscribe", as: "unsubscribe"

  # this route is for de-bugging fetching a user's posts. Prob will delete later
  get '/instagram/:user/posts', to: 'followees#insta_user_posts', as: "iuser_posts"


end
