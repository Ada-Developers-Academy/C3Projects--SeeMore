class ApiHelper
  # this goes in api helper
  def self.user_search(query, count, source)
    case source
    when ApplicationController::INSTAGRAM
      InstagramApi.new.user_search(query, count)
    when ApplicationController::TWITTER
      TwitterApi.new.user_search(query, count)
    end
  end
end
