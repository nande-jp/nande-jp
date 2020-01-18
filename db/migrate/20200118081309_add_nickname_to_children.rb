class AddNicknameToChildren < ActiveRecord::Migration[5.2]
  def change
    add_column :children, :nickname, :string
  end
end
