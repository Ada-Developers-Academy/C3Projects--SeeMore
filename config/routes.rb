Rails.application.routes.draw do
  root "welcome#index"

  # authorization routes -------------------------------------------------------
  # omniauth developer strategy
  get "/auth/developer", as: "sign_up"
  post "/auth/developer/callback", to: "sessions#create"
  # OPTIMIZE: should we delete or uncomment this :provider callback route? we're not using it at present.
  # get "/auth/:provider/callback", to: "sessions#create"
  # omniauth production strategy
  get "/auth/instagram/callback" => 'sessions#create_instagram'
  get "/auth/vimeo/callback" => 'sessions#create_vimeo'
  # logging out
  delete "/logout", to: "sessions#destroy", as: "logout"

  # feed routes
  get "/feed/:feed_id", to: "instagram#individual_feed", as: "feed"
  post "/feed/:feed_id/subscribe", to: "instagram#subscribe", as: "subscribe"
  get "/vimeo/feed/:feed_id", to: "vimeo#individual_feed", as: "vimeo_feed"
  post "/vimeo/feed/:feed_id/subscribe", to: "vimeo#subscribe", as: "vimeo_subscribe"

  # search routes
  post "/search", to: "instagram#search"
  get "/results/:query", to: "instagram#results", as: "results"
  post "vimeo/search", to: "vimeo#search"
  get "vimeo/results/:query", to: "vimeo#results", as: "vimeo_results"
end
