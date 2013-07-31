class AddAccountIdToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :account_id, :integer
  end
end
