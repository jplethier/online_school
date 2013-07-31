# == Schema Information
#
# Table name: classrooms
#
#  id         :integer          not null, primary key
#  subject_id :integer
#  created_at :datetime
#  updated_at :datetime
#  account_id :integer
#  teacher_id :integer
#

class Classroom < ActiveRecord::Base
  belongs_to :account
  belongs_to :subject
  belongs_to :teacher, class_name: 'User'

  validates :account, presence: true
  validates :subject, presence: true
end
