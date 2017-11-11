class AddIndexUniqueToReviews < ActiveRecord::Migration[5.1]
  def change
    add_index :reviews, [:company_id, :user_id], unique: true
  end
end
