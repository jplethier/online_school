# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Plan < ActiveRecord::Base
  attr_accessible :title

  validates :title, presence: true
end
