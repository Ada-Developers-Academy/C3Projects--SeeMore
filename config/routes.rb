Rails.application.routes.draw do
<<<<<<< HEAD
  root 'sessions#home'

# OAuth ROUTES ------------------------------------------------------
  match "auth/:provider/callback", to: "sessions#create", via: [:get, :post]

# INSTAGRAM ROUTES --------------------------------------------------
  get "/i/:user" => "followees#insta_users", as: "iusers"
  post "/i" => "followees#users_redirect", as: "iuser_search"
=======
  root 'home#landing_page'
  match "auth/:provider/callback", to: "sessions#create", via: [:get, :post]

  get 'search', to: 'home#search', as: 'search'
  post 'search_twitter', to: 'home#twitter_users_redirect', as: 'twitter_users_redirect'
  get 'twitter_users/:user', to: 'home#twitter_users', as: 'twitter_users'
>>>>>>> FeedMe

end
