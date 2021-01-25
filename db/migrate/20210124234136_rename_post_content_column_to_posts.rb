class RenamePostContentColumnToPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :post_content, :post_body
  end
end
