class AddGroupIdsToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :group_ids, :string
  end
end
