class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :period
      t.integer :classroom_id
      t.string :kind

      t.timestamps
    end
  end
end
