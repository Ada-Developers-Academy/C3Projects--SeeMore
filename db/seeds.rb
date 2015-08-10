require 'csv'

CSV.foreach("db/followees.csv", headers: true) do |row|
  Followee.create(
    handle: row[0],
    source: row[1],
    avatar_url: row[2],
    native_id: row[3],
    last_post_id: row[4]   
  )
end

# followees = [
#   { handle: "beyonce", 
#     source: "twitter", 
#     avatar_url: "http://pbs.twimg.com/profile_images/582395896593170432/pw_jGziR_normal.jpg", 
#     native_id: 31239408,
#     last_post_id: "369486010280706048"},
#   { handle: "rihanna", 
#     source: "twitter", 
#     avatar_url: "http://pbs.twimg.com/profile_images/582747937958076418/ZrNhtrD2_normal.jpg", 
#     native_id: 79293791,
#     last_post_id: ""},
#   { handle: "NICKIMINAJ", 
#     source: "twitter", 
#     avatar_url: "http://pbs.twimg.com/profile_images/628666793222082561/CcerTIf6_normal.jpg", 
#     native_id: 35787166,
#     last_post_id: "630811487406288897"},
#   { handle: "beyonce", 
#     source: "instagram", 
#     avatar_url: "https://igcdn-photos-g-a.akamaihd.net/hphotos-ak-xft1/t51.2885-19/11098624_1632794343609174_1724291661_a.jpg", 
#     native_id: 247944034,
#     last_post_id: ""},
#   { handle: "badgalriri", 
#     source: "instagram", 
#     avatar_url: "https://igcdn-photos-c-a.akamaihd.net/hphotos-ak-xaf1/t51.2885-19/11032926_1049846535031474_260957621_a.jpg", 
#     native_id: 25945306,
#     last_post_id: ""} ,
#   { handle: "nickiminaj", 
#     source: "instagram", 
#     avatar_url: "https://igcdn-photos-d-a.akamaihd.net/hphotos-ak-xfa1/t51.2885-19/s150x150/11820626_1619202511669867_2070537136_a.jpg", 
#     native_id: 451573056,
#     last_post_id: ""}
# ]

# followees.each do |followee|
#   Followee.create(followee)
# end

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
