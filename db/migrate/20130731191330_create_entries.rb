class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :resource_id
      t.string :resource_type
      t.integer :classroom_id

      t.timestamps
    end

    add_index :entries, :classroom_id
  end
end
