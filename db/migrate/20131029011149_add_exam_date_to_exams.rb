class AddExamDateToExams < ActiveRecord::Migration
  def change
    add_column :exams, :exam_date, :datetime
  end
end
