class AddCountersToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :questions_count, :integer, default: 0
    add_column :users, :answers_count, :integer, default: 0

    User.find_each do |user|
      User.reset_counters(user.id, :answers)
      User.reset_counters(user.id, :questions)
    end
  end
end
