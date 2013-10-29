class Exam < ActiveRecord::Base
  belongs_to :account
  belongs_to :classroom

  validates :account,   presence: true
  validates :classroom, presence: true
  validates :exam_date, presence: true
  validates :kind,      presence: true
  validates :period,    numericality: { only_integer: true }
end
