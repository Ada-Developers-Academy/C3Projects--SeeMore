Rails.application.routes.draw do
  post "/auth/:provider/callback", to: "sessions#create"
  #get "/auth/:provider"
end
