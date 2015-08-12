class ApiHelper
  def self.user_search(query, count, source)
    case source
    when ApplicationController::INSTAGRAM
      InstagramApi.new.user_search(query, count)
    when ApplicationController::TWITTER
      TwitterApi.new.user_search(query, count)
    end
  end

  def self.process_new_posts(subscriptions)
    subscriptions.each do |subscription|
      followee = subscription.followee
      source = followee.source
      posts = get_posts_from_API(followee)

      Post.create_posts_and_update_followee(posts, followee, source)
    end
  end

  def self.get_posts_from_API(followee)
    last_post_id = followee.last_post_id
    source = followee.source

    case source
    when ApplicationController::TWITTER
      id = followee.native_id.to_i
      posts = TwitterApi.new.get_posts(id, last_post_id)
    when ApplicationController::INSTAGRAM
      id = followee.native_id
      posts = InstagramMapper.get_posts(id, last_post_id)
    end

    posts
  end

  def self.post_params(post, followee, source)
    case source
    when ApplicationController::TWITTER
      TwitterMapper.format_params(post, followee)
    when ApplicationController::INSTAGRAM
      InstagramMapper.format_params(post, followee)
    end
  end
end
