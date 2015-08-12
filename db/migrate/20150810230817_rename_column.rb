class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :grams, :type, :media_type
  end
end
