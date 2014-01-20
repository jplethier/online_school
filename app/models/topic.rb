class Topic < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :user

  validates :user_id,      presence: true
  validates :classroom_id, presence: true
  validates :message,      presence: true
end
