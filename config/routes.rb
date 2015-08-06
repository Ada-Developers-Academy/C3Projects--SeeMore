Rails.application.routes.draw do
  root 'home#newsfeed'

  get '/signin', to: 'home#signin', as: 'signin'

  match "auth/:provider/callback", to: "sessions#create", via: [:get, :post]

  get "/instagram/:user" => "followees#insta_users", as: "iusers"
  post "/instagram_users" => "followees#users_redirect", as: "iuser_search"

  get 'search', to: 'home#search', as: 'search'
  post 'search_twitter', to: 'home#twitter_users_redirect', as: 'twitter_users_redirect'
  get 'twitter_users/:user', to: 'home#twitter_users', as: 'twitter_users'

end
