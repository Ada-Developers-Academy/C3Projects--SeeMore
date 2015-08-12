# in a for reals awesome app we would want this to be more frequent but due to the rate limits of both APIs we cannot update more frequently.git aff
every 2.hours do
  runner "Feed.update_vimeo_feed"
  runner "Feed.update_instagram_feed"
end

# Learn more: http://github.com/javan/whenever
