Rails.application.routes.draw do
  root 'sessions#home'
  match "auth/:provider/callback", to: "sessions#create", via: [:get, :post]
end
