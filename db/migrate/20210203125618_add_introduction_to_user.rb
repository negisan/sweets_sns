class AddIntroductionToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :introduction, :string
  end

  def down
    remove_column :users, :introduction, :string
  end
end
