class Classroom < ActiveRecord::Base
  belongs_to :account
  belongs_to :subject
  belongs_to :teacher, class_name: 'User'

  has_many :entries, inverse_of: :classroom
  has_many :user_groups, through: :entries
  has_many :users,  through: :user_groups, source: :user
  has_many :groups, through: :user_groups, source: :group

  has_many :exams
  has_many :topics

  validates :account, presence: true
  validates :subject, presence: true

  after_save :update_groups

  scope :ordered_by_name, lambda { joins{ subject }.order{ subject.name } }
  scope :search, lambda { |query| joins{ subject }.where{subject.name =~ "%#{query.gsub(' ','%')}%"} }

  accepts_nested_attributes_for :entries, allow_destroy: true

  attr_accessor :temporary_group_ids

  def temporary_group_ids
    @temporary_group_ids ||= []
  end

  def groups_names
    self.groups.pluck(:name).join(', ')
  end

  private

  def update_groups
    create_new_groups_entries
    remove_deleted_groups_entries
  end

  def create_new_groups_entries
    temporary_group_ids.each do |group_id|
      UserGroup.where(group_id: group_id).each do |user_group|
        user_group.entries.create(classroom: self)
      end
    end
  end

  def remove_deleted_groups_entries
    (group_ids - temporary_group_ids).each do |group_id|
      Entry.includes(:user_group).destroy_all(classroom_id: id, user_group: { group_id: group_id })
    end
  end
end
