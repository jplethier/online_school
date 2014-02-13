class AddUniquenessToEntryClassroomAndUserGroup < ActiveRecord::Migration
  def change
    add_index :entries, [:classroom_id, :user_group_id], unique: true
  end
end
