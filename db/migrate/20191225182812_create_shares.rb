class CreateShares < ActiveRecord::Migration[5.2]
  def change
    create_table :shares do |t|
      t.belongs_to :answer
      t.belongs_to :user
      t.timestamps
    end
  end
end
