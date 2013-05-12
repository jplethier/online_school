# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  enrollment             :string(255)
#  phone_number           :string(255)
#  cellphone_number       :string(255)
#  birth_date             :date
#  address                :string(255)
#  address_number         :string(255)
#  address_complement     :string(255)
#  address_city           :string(255)
#  address_state          :string(255)
#  account_id             :integer
#  student                :boolean
#  teacher                :boolean
#  employee               :boolean
#  admin                  :boolean
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  belongs_to :account

  accepts_nested_attributes_for :account, :allow_destroy => true

  scope :students,  lambda { where(student: true) }
  scope :teachers,  lambda { where(teacher: true) }
  scope :employees, lambda { where(employee: true) }
  scope :admins,    lambda { where(admin: true) }
end
