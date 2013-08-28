class Subject < ActiveRecord::Base
  has_many :classrooms

  belongs_to :account

  validates :account, presence: true
  validates :name,    presence: true
end
