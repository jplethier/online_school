class AddAccountIdToExams < ActiveRecord::Migration
  def change
    add_column :exams, :account_id, :integer

    add_index :exams, :account_id
  end
end
