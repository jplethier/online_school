class StudentExam < ActiveRecord::Base
  belongs_to :exam
  belongs_to :student, class_name: 'User'

  validates :exam,    presence: true
  validates :grade,   numericality: true, presence: true
  validates :student, presence: true
end
