# since Vimeo does not publicly list their rate limits, we're basing these
# numbers off the Instagram rate limits, which are 5,000 API calls per hour.
# that works out to 83 calls per minute. in the worst case scenario, with the
# numbers below we'll be using 4 calls per minute for updating our cached feeds.
# that leaves 79 for users of our site searching for new threads to subscribe to.

every 12.hours do # TODO: run the heroku equivalent of this bash command: whenever --update-crontab
  rake "update_feeds:update"
end
