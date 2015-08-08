require 'csv'

# CSV.foreach("db/followees.csv", headers: true) do |row|
#   image_path = "app/assets/images/" + row[2]

#   Followee.create(
#     handle: row[0],
#     source: row[1],
#     avatar_url: open(image_path)
#   )
# end

new_followees = [
  { handle: "vp", 
    source: "twitter", 
    avatar_url: "http://pbs.twimg.com/profile_images/464835807837044737/vO0cnKR1_normal.jpeg", 
    native_id: "325830217" }
]

new_followees.each do |followee|
  Followee.create(followee)  
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
