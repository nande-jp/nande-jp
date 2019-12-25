class AddBookmarksCountToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :bookmarks_count, :integer, default: 0
  end
end
