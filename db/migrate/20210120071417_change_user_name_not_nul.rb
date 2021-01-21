class ChangeUserNameNotNul < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :name, :string, null: false, default: 'guest'
  end

  def down
    change_column :users, :name, :string
  end
end
