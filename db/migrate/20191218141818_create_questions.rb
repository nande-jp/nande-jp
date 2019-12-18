class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :content
      t.belongs_to :user
      t.integer :category
      t.timestamps
    end
  end
end
