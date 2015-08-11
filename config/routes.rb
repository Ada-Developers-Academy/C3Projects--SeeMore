Rails.application.routes.draw do
  root 'home#newsfeed'

  get '/refresh', to: 'home#refresh', as: 'refresh' 

  get '/signin', to: 'home#signin', as: 'signin'
  delete 'signout', to: 'sessions#destroy', as: 'signout'

  match "/auth/:provider/callback", to: "sessions#create", via: [:get, :post]


  # Search page
  get '/search', to: 'followees#search', as: "search"

  # Redirect (checks if search field is filled in)
  post "/instagram_users", to: "followees#instagram_users_redirect", as: "instagram_users_redirect"
  post '/twitter_users', to: 'followees#twitter_users_redirect', as: 'twitter_users_redirect'

  # Search Results
  get '/search/:source/:user', to: "followees#search_results", as: "search_results"

  # post '/subscriptions/:user', to: 'subscriptions#create', as: 'subscribe'
  # need to limit the subscription paths
  resources :subscriptions

  post "/unsubscribe/:id", to: "subscriptions#unsubscribe", as: "unsubscribe"

  # this route is for de-bugging fetching a user's posts. Prob will delete later
  get '/instagram/:followee/posts', to: 'followees#insta_posts', as: "insta_posts"
  get '/twitter/:followee/posts', to: 'followees#twitter_posts', as: "twit_posts"

  post '/posts', to: 'posts#create', as: 'posts'

  post '/', to: 'home#get_new_posts', as: 'get_new_posts'

end
