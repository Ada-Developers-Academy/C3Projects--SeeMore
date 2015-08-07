require 'csv'

CSV.foreach("db/followees.csv", headers: true) do |row|
  image_path = "app/assets/images/" + row[2]

  Followee.create(
    handle: row[0],
    source: row[1],
    avatar_url: open(image_path)
  )
end

CSV.foreach("db/subscriptions.csv", headers: true) do |row|
  Subscription.create(
    user_id: row[0],
    followee_id: row[1],
    unsubscribe_date: row[2]
  )
end

CSV.foreach("db/users.csv", headers: true) do |row|
  User.create(
    name: row[0],
    email: row[1],
    avatar_url: row[2],
    uid: row[3],
    provider: row[4]
  )
end
