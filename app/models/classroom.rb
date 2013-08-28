class Classroom < ActiveRecord::Base
  belongs_to :account
  belongs_to :subject
  belongs_to :teacher, class_name: 'User'

  has_many :entries, inverse_of: :classroom
  has_many :users,   through: :entries, source: :user,  conditions: "entries.resource_type = 'User'"
  has_many :groups,  through: :entries, source: :group, conditions: "entries.resource_type = 'Group'"

  validates :account, presence: true
  validates :subject, presence: true

  scope :ordered_by_name, lambda { joins{ subject }.order{ subject.name } }
  scope :search, lambda { |query| joins{ subject }.where{subject.name =~ "%#{query.gsub(' ','%')}%"} }

  accepts_nested_attributes_for :entries, allow_destroy: true

  def groups_names
    self.groups.map { |group| [group.name] }.join(', ')
  end
end
