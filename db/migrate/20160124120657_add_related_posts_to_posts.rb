class AddRelatedPostsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :related_posts, :string
  end
end
