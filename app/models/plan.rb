# == Schema Information
#
# Table name: plans
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  price           :float
#  students_number :integer
#

class Plan < ActiveRecord::Base
  validates :price,           numericality: true, presence: true
  validates :students_number, numericality: true, presence: true
  validates :title, presence: true
end
