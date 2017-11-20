class AddFieldToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :training_rate, :integer
    add_column :reviews, :culture_rate, :integer
    add_column :reviews, :ot_rate, :integer
  end
end
