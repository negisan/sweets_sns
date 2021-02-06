class AddProhibitionToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :prohibition, :boolean, default: false
  end

  def down
    remove_column :users, :prohibition, :boolean
  end
end
