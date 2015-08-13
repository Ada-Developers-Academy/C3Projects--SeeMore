namespace :update_feeds do
  desc "update feeds on a timely basis so users will see delicious, fresh content"
  task update: :environment do
    feeds = Feed.all
    feeds.each do |feed|
      feed.update_feed

      puts "#{ feed.name } updated! sleeping for 5 seconds now."
      sleep(5.seconds)
    end

    puts "#{Time.now} - Success!"
  end
end
