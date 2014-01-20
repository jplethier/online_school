class EntrySettings < ActiveRecord::Base
  belongs_to :entry
  belongs_to :topic

  validates :entry_id, presence: true
  validates :topic_id, presence: true
end
