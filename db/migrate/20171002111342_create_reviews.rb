class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :salary_benefit_rate
      t.integer :office_workspace_rate
      t.integer :care_about_staff_rate

      t.timestamps
    end
  end
end
