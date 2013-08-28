class Classroom < ActiveRecord::Base
  belongs_to :account
  belongs_to :subject
  belongs_to :teacher, class_name: 'User'

  has_many :entries, inverse_of: :classroom
  has_many :users,   through: :entries, source: :resource, source_type: "User"
  has_many :groups,  through: :entries, source: :resource, source_type: "Group"

  validates :account, presence: true
  validates :subject, presence: true

  # scope :ordered_by_name, lambda { order('subjects.name') }
  scope :search, lambda { |query| where{subject.name =~ "%#{query.gsub(' ','%')}%"} }

  accepts_nested_attributes_for :entries, allow_destroy: true
end
