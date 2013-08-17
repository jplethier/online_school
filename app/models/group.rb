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

  has_many :user_groups, inverse_of: :group
  has_many :students, through: :user_groups, source: :user

  has_many :entries, as: :resource
  has_many :classrooms, through: :entries

  validates :account,     presence: true
  validates :name,        presence: true
  validates :user_groups, associated: true

  accepts_nested_attributes_for :user_groups, allow_destroy: true

  scope :ordered_by_name, lambda { order('name') }
  scope :search, lambda { |query| where{name =~ "%#{query.gsub(' ','%')}%"} }
end
