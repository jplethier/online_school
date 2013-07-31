class Entry < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :resource, polymorphic: true

  validates :classroom, presence: true
  validates :resource, presence: true
end
