class Topic < ActiveRecord::Base
  belongs_to :account
  belongs_to :classroom
  belongs_to :user

  has_many :entry_settings

  validates :account_id,   presence: true
  validates :classroom_id, presence: true
  validates :user_id,      presence: true
  validates :message,      presence: true
end
