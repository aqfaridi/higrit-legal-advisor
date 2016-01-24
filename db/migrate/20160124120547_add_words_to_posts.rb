class AddWordsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :words, :text
  end
end
