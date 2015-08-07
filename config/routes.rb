Rails.application.routes.draw do
  root 'home#newsfeed'

  get '/signin', to: 'home#signin', as: 'signin'

  match "/auth/:provider/callback", to: "sessions#create", via: [:get, :post]


  # Search page
  get '/insta_search', to: "followees#insta_search", as: "insta_search"
  get '/search', to: 'home#search', as: 'search'
  
  # Redirect (checks if search field is filled in)
  post "/instagram_users", to: "followees#instagram_users_redirect", as: "instagram_users_redirect"
  post '/twitter_users', to: 'followees#twitter_users_redirect', as: 'twitter_users_redirect'

  # Search Results
  get '/search/:user', to: "followees#search_results", as: "search_results"
  # get "/instagram/:user" => "followees#insta_users", as: "iusers"
  # get '/twitter_users/:user', to: 'home#twitter_users', as: 'twitter_users'

  resources :subscription

  post "/unsubscribe/:id", to: "subscriptions#unsubscribe", as: "unsubscribe"

  # this route is for de-bugging fetching a user's posts. Prob will delete later
  get '/instagram/:user/posts', to: 'followees#insta_user_posts', as: "iuser_posts"

  get '/search_final', to: 'followees#search', as: "search_final"

end
