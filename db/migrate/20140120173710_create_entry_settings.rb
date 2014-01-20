class CreateEntrySettings < ActiveRecord::Migration
  def change
    create_table :entry_settings do |t|
      t.integer :entry_id
      t.integer :topic_id
      t.boolean :follow, default: false

      t.timestamps
    end

    add_index :entry_settings, :topic_id
    add_index :entry_settings, :entry_id
  end
end
