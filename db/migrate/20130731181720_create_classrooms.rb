class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.integer :subject_id

      t.timestamps
    end

    add_index :classrooms, :subject_id
  end
end
