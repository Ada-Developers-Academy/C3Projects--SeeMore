class AddProviderColumnToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :provider, :string

    Post.all.each do |post|
      post.update(provider: "default")
    end

    change_column_null :posts, :provider, false
  end

  def down
    remove_column :posts, :provider
  end
end
