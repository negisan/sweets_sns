class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :post_image
      t.string :post_content

      t.timestamps
    end
  end
end
