class Post < ActiveRecord::Base
  belongs_to :account
  belongs_to :topic
  belongs_to :user

  validates :account_id, presence: true
  validates :message,    presence: true
  validates :topic_id,   presence: true
  validates :user_id,    presence: true
end
