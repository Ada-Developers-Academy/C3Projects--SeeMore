# create some authenticated users ----------------------------------------------
user1 = AuUser.create(name: "bicycle fan (seed)", uid: 99901,
  avatar: "/seeds/user1.png", email: "bicycle.seed@email.net")
user2 = AuUser.create(name: "triangles (seed)", uid: 99902,
  avatar: "/seeds/user2.png", email: "triangles.seed@email.net")
user3 = AuUser.create(name: "horse pasture (seed)", uid: 99903,
  avatar: "/seeds/user3.png", email: "horse.seed@email.net")
user4 = AuUser.create(name: "puppy (seed)", uid: 99904,
  avatar: "/seeds/user4.png", email: "puppy.seed@email.net")
user5 = AuUser.create(name: "pink dream (seed)", uid: 99905,
  avatar: "/seeds/user5.png", email: "pink.seed@email.net")
user6 = AuUser.create(name: "trash can (seed)", uid: 99906,
  avatar: "/seeds/user6.png", email: "trash.seed@email.net")

# give them some feeds to subscribe to -----------------------------------------
# note: these are all instagram feed ids
cheese_cake_ru_feed = Feed.create(platform_feed_id: 1184782014,
  platform: "Developer", avatar: "/seeds/user7.png", name: "cheese_cake_ru")
cheeseharris_feed = Feed.create(platform_feed_id: 538175012,
  platform: "Developer", avatar: "/seeds/user8.png", name: "cheeseharris")
golden_egg_feed = Feed.create(platform_feed_id: 1417351781,
  platform: "Developer", avatar: "/seeds/user9.png", name: "_golden_egg_")
puppystagrams_feed = Feed.create(platform_feed_id: 1559136659,
  platform: "Developer", avatar: "/seeds/user10.png", name: "puppystagrams")
cats_of_world_feed = Feed.create(platform_feed_id: 484554895,
  platform: "Developer", avatar: "/seeds/user11.png", name: "cats_of_world")
sharksdaily_feed = Feed.create(platform_feed_id: 283281926,
  platform: "Developer", avatar: "/seeds/user12.png", name: "sharks_daily")
hiking_trails_feed = Feed.create(platform_feed_id: 2008924933,
  platform: "Developer", avatar: "/seeds/user1.png", name: "hiking_trails")
star_trek_feed = Feed.create(platform_feed_id: 221700878,
  platform: "Developer", avatar: "/seeds/user2.png", name: "star_trek")
scandal_feed = Feed.create(platform_feed_id: 338623854,
  platform: "Developer", avatar: "/seeds/user3.png", name: "scandal")
jerome_boateng_feed = Feed.create(platform_feed_id: 192998906,
  platform: "Developer", avatar: "/seeds/user4.png", name: "jerome_boateng")

# subscribe most of the seed users to some of those feeds ----------------------
user1.feeds << cheese_cake_ru_feed
user1.feeds << cheeseharris_feed
user1.feeds << golden_egg_feed

user2.feeds << puppystagrams_feed
user2.feeds << cats_of_world_feed
user2.feeds << sharksdaily_feed
user2.feeds << hiking_trails_feed

user3.feeds << star_trek_feed
user3.feeds << scandal_feed

user4.feeds << jerome_boateng_feed

user5.feeds << cheeseharris_feed
user5.feeds << golden_egg_feed
user5.feeds << puppystagrams_feed
user5.feeds << cats_of_world_feed
