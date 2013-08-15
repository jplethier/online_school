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

  has_many :entries, inverse_of: :classroom
  has_many :users,   through: :entries, source: :resource, source_type: "User"
  has_many :groups,  through: :entries, source: :resource, source_type: "Group"

  validates :account, presence: true
  validates :subject, presence: true
end
