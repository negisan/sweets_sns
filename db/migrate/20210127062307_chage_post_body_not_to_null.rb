class ChagePostBodyNotToNull < ActiveRecord::Migration[6.0]
  def up
    change_column :posts, :body, :string, null: false
  end

  def down
    change_column :posts, :body, :string
  end
end
