class AddChildIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :child_id, :integer
    add_index :questions, :child_id
  end
end
