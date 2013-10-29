class CreateStudentExams < ActiveRecord::Migration
  def change
    create_table :student_exams do |t|
      t.integer :student_id
      t.integer :exam_id
      t.float :grade

      t.timestamps
    end
  end
end
