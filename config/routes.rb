Rails.application.routes.draw do
  root 'sessions#home'

# OAuth ROUTES ------------------------------------------------------
  match "auth/:provider/callback", to: "sessions#create", via: [:get, :post]

# INSTAGRAM ROUTES --------------------------------------------------
  get "/i/:user" => "followees#insta_users", as: "iusers"
  post "/i" => "followees#users_redirect", as: "iuser_search"

end
