class AddBooleanFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :student, :boolean
    add_column :users, :teacher, :boolean
    add_column :users, :employee, :boolean
    add_column :users, :admin, :boolean
  end
end
