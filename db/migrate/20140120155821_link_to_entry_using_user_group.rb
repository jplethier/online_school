class LinkToEntryUsingUserGroup < ActiveRecord::Migration
  def change
    remove_column :entries, :resource_id
    remove_column :entries, :resource_type

    add_column :entries, :user_group_id, :integer
    add_index :entries, :user_group_id
  end
end
