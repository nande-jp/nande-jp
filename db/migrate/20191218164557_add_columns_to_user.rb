class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :introduction, :text
    add_column :users, :prefecture, :string
    add_column :users, :city, :string
  end
end
