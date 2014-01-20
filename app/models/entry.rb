class Entry < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :user_group

  has_many :entry_settings

  validates :classroom, presence: true
  validates :user_group, presence: true
end
