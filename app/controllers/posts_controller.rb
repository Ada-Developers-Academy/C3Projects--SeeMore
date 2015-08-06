class PostsController < ApplicationController
  def index
    # We did this so that we could see the provider of the logged-in user on
    # the homepage
      @stalker = Stalker.find(session[:stalker_id])
    # TODO: fill this in
  end
  <%= link_to "Sign Out", logout_path, method: :delete, class: "btn btn-default" %>
end
