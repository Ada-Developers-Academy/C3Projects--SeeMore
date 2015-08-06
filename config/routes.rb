Rails.application.routes.draw do
  root 'posts#index'

  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create" # this is required for the OmniAuth Developer Strategy
  #  get "/auth/:provider", to: "sessions#create"
   post "/auth/:provider", to: "sessions#create"
   get "auth/developer" => 'sessions#create', as: 'login'
   delete "logout" => 'sessions#destroy'

   resources :instagram, only: [:index]
end
