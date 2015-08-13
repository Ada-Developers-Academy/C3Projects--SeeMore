Rails.application.routes.draw do
  root "welcome#index"

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

  # search routes --------------------------------------------------------------
  post "/search", to: "welcome#search", as: "search"
  get "/instagram/:query", to: "instagram#results", as: "instagram_results"
  get "/vimeo/:query", to: "vimeo#results", as: "vimeo_results"

  # search routes --------------------------------------------------------------
  get "/instagram", to: "welcome#view_instagram_feed", as: "instagram"
  get "/vimeo", to: "welcome#view_vimeo_feed", as: "vimeo"
end
