Rails.application.routes.draw do
  get 'home/search'

  root 'home#landing_page'
  match "auth/:provider/callback", to: "sessions#create", via: [:get, :post]
end
