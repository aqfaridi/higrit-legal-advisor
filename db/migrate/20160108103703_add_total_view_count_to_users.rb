class AddTotalViewCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_view_count, :integer , :default => 0
  end
end
