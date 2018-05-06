class ChangeColumnToFriendships < ActiveRecord::Migration[5.0]
  def change
  	change_column :friendships, :friendship_accepted, :boolean, :default => false
  end
end
