class ChangeColumnReviews < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :salary_benefit_rate, :salary_rate
    rename_column :reviews, :office_workspace_rate, :workspace_rate
    rename_column :reviews, :care_about_staff_rate, :care_rate
    add_column    :reviews, :summary_rate, :integer
  end
end
