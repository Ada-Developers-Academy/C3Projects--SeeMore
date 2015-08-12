# in a for reals awesome app we would want this to be more frequent but due to the rate limits of both APIs we cannot update more frequently.
every 2.hours do
  runner "Feed.instagram_update_method"
  runner "Feed.vimeo_update_method"
end

# Learn more: http://github.com/javan/whenever
