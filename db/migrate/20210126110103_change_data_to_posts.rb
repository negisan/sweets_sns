class ChangeDataToPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :image, :string
    change_column :posts, :body, :string
  end
end
