if Rails.env.development?
  prey = [
    { name: "Ashley Watkins",
      username: "catchingash",
      provider: "twitter",
      uid: "3037739230",
      photo_url: "https://pbs.twimg.com/profile_images/625870213901193216/usGZawYA_normal.jpg",
      profile_url: "https://twitter.com/catchingash"
    }
  ]

  prey.each do |prey_params|
    Prey.create(prey_params)
  end
end
