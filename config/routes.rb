Rails.application.routes.draw do
  # everybody routes -----------------------------------------------------------
  root "welcome#index"
  get "/about" => "welcome#about"

  # authorization routes -------------------------------------------------------
  get "/auth/instagram/callback" => "sessions#create_instagram"
  get "/auth/vimeo/callback" => "sessions#create_vimeo"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # feed routes ----------------------------------------------------------------
  # instagram
  get "/instagram/feed/:feed_id", to: "instagram#individual_feed", as: "instagram_feed"
  post "/instagram/feed/:feed_id/subscribe", to: "instagram#subscribe", as: "instagram_subscribe"
  delete "/instagram/feed/:feed_id/unsubscribe", to: "instagram#unsubscribe", as: "instagram_unsubscribe"
  # vimeo
  get "/vimeo/feed/:feed_id", to: "vimeo#individual_feed", as: "vimeo_feed"
  post "/vimeo/feed/:feed_id/subscribe", to: "vimeo#subscribe", as: "vimeo_subscribe"
  delete "/vimeo/feed/:feed_id/unsubscribe", to: "vimeo#unsubscribe", as: "vimeo_unsubscribe"
  # summary
  get "/feeds" => "welcome#all_feeds"

  # search routes --------------------------------------------------------------
  post "/search", to: "welcome#search", as: "search"
  get "/instagram/:query", to: "instagram#results", as: "instagram_results"
  get "/vimeo/:query", to: "vimeo#results", as: "vimeo_results"
end
