class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :uid
      t.string :provider
      t.string :avatar_url

      t.timestamps null: false
    end
  end
end
