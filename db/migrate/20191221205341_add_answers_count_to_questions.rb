class AddAnswersCountToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :answers_count, :integer
  end
end
