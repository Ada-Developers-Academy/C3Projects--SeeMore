class AddColumnsToInstagrams < ActiveRecord::Migration
  def change
    add_column :instagrams, :username, :string
    add_column :instagrams, :provider_id, :string

    change_column :instagrams, :username, :string, :null => false
    change_column :instagrams, :provider_id, :string, :null => false
  end
end
