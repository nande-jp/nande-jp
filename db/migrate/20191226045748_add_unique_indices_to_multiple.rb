class AddUniqueIndicesToMultiple < ActiveRecord::Migration[5.2]
  def change
    add_index :bookmarks, [:user_id, :answer_id], unique: true
    add_index :follows, [:follower_id, :following_id], unique: true
    add_index :shares, [:user_id, :answer_id], unique: true
  end
end
