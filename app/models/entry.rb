class Entry < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :resource, polymorphic: true
  belongs_to :group,    class_name: 'Group', foreign_key: :resource_id
  belongs_to :user,     class_name: 'User',  foreign_key: :resource_id

  has_many :entry_settings

  validates :classroom, presence: true
  validates :resource, presence: true
end
