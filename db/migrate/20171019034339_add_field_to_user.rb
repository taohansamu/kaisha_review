class AddFieldToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gender, :string
    add_column :users, :occupation, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :number_phone, :string
  end
end
