class RemoveImageColumnToPost < ActiveRecord::Migration[6.0]
  def up
    remove_column :posts, :image, :string
  end

  def down
    add_column :posts, :image, :string
  end
end
