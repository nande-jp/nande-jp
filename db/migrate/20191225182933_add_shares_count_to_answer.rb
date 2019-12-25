class AddSharesCountToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :shares_count, :integer, default: 0
  end
end
