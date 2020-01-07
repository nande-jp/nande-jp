class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.belongs_to :user
      t.integer :age
      t.integer :gender
      t.timestamps
    end
  end
end
