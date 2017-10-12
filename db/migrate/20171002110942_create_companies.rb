class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :employees
      t.string :website
      t.string :address
      t.integer :estabish
      t.integer :investment
      t.string :cover
      t.float :rank

      t.timestamps
    end
  end
end
