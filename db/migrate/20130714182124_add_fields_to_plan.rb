class AddFieldsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :price, :float
    add_column :plans, :students_number, :integer
  end
end
