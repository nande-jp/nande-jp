class AddGenderToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer
    add_column :users, :age, :integer
  end
end
