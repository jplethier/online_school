# == Schema Information
#
# Table name: user_groups
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates :user,  presence: true
  validates :group, presence: true
end
