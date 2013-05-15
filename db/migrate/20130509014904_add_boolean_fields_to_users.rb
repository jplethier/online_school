class AddBooleanFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :student,  :boolean, default: false
    add_column :users, :teacher,  :boolean, default: false
    add_column :users, :employee, :boolean, default: false
    add_column :users, :admin,    :boolean, default: false
  end
end
