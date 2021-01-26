class RenameColumnToPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :post_image, :image
    rename_column :posts, :post_body, :body
  end
end
