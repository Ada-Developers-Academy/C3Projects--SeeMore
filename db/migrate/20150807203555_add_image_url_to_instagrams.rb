class AddImageUrlToInstagrams < ActiveRecord::Migration
  def change
    add_column :instagrams, :image_url, :string
  end
end
