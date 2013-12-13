# == Schema Information
#
# Table name: plans
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  price           :float
#  students_number :integer
#

class Plan < ActiveRecord::Base
  has_many :accounts

  validates :price,           numericality: true, presence: true
  validates :students_number, numericality: true, presence: true
  validates :title, presence: true

  scope :order_by_price, order('price')

  def title_with_price
    "#{self.title} - R$ #{self.price}"
  end
end
