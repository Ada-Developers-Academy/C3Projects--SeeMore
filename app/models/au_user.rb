class AuUser < ActiveRecord::Base
  has_and_belongs_to_many :feeds
  has_many :posts, through: :feeds

  validates :uid, :provider, :name, :presence => true

  def unsubscribe(id) # FIXME: test this Jeri
    feed = Feed.find(id)
    self.feeds.delete(feed)
    feed.destroy if feed.au_users.empty?
  end

  def self.create_with_omniauth(auth)
    create! do |au_user|
      au_user.provider = auth["provider"]
      au_user.uid = auth["uid"]
      au_user.name = auth["info"]["name"]
      au_user.email = auth["info"]["email"]
      if auth["info"]["pictures"]
        au_user.avatar = auth["info"]["pictures"][0]["link"]
      else
        au_user.avatar = nil
      end
    end
  end
end
