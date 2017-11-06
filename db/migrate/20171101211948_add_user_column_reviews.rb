class AddUserColumnReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :user,:as_json
  end
end
