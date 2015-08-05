class CreateAuUsers < ActiveRecord::Migration
  def change
    create_table :au_users do |t|
      t.string :provider
      t.string :name
      t.string :uid
      t.string :avatar
      t.string :email

      t.timestamps null: false
    end
  end
end
