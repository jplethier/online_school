class Entry < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :resource, polymorphic: true
  belongs_to :group,    class_name: 'Group', foreign_key: :resource_id
  belongs_to :user,     class_name: 'User',  foreign_key: :resource_id

  validates :classroom, presence: true
  validates :resource, presence: true
end
