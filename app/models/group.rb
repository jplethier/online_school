# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  account_id :integer
#

class Group < ActiveRecord::Base
  belongs_to :account
  has_many :user_groups
  has_many :users, through: :user_groups

  validates :account, presence: true
  validates :name,    presence: true
end
