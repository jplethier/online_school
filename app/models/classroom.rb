# == Schema Information
#
# Table name: classrooms
#
#  id         :integer          not null, primary key
#  subject_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Classroom < ActiveRecord::Base
  belongs_to :subject

  validates :subject, presence: true
end
