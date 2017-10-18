class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :logo, null: false
      t.string :cover
      t.textarea  :overview
      t.integer :employees
      t.string :website
      t.string :address
      t.integer :estabish
      t.integer :investment
      t.float :rank, default: 0
      t.timestamps
    end
    add_index :companies, [:user_id, :created_at]
  end
end
