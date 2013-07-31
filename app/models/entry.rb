# == Schema Information
#
# Table name: entries
#
#  id            :integer          not null, primary key
#  resource_id   :integer
#  resource_type :string(255)
#  classroom_id  :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Entry < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :resource, polymorphic: true

  validates :classroom, presence: true
  validates :resource, presence: true
end
