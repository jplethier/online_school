class Exam < ActiveRecord::Base
  belongs_to :classroom

  validates :classroom, presence: true
  validates :exam_date, presence: true
  validates :kind,      presence: true
  validates :period,    numericality: { only_integer: true }
end
