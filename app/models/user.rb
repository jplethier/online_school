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
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  devise :confirmable, :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, request_keys: [:subdomain]

  belongs_to :account
  has_many :user_groups
  has_many :groups, through: :user_groups

  has_attached_file :avatar, styles: { big: "200x212>", thumb: "60x75>" }, default_url: "/users/avatars/:style/missing.png", url: "users/avatars/:id_partition/:style.:extension", path: "users/avatars/:id_partition/:style.:extension"

  validates :email, presence: true
  validates :email, uniqueness: { scope: :account_id }, if: :email_changed?
  validates :email, format: { with: Devise.email_regexp }, if: :email_changed?

  validates :name, presence: true
  validates :enrollment, presence: true, if: :student?

  validates :password, presence: true, confirmation: true, length: { within: Devise.password_length }, if: :password_required?

  accepts_nested_attributes_for :account, :allow_destroy => true

  attr_accessor :group_ids

  scope :students,  lambda { where(student: true) }
  scope :teachers,  lambda { where(teacher: true) }
  scope :employees, lambda { where(employee: true) }
  scope :admins,    lambda { where(admin: true) }

  scope :search, lambda { |query| where{name =~ "%#{query.gsub(' ','%')}%"} }

  def self.find_for_authentication(warden_conditions)
    if account = Account.find_by_subdomain(warden_conditions[:subdomain])
      account.users.find_by_email(warden_conditions[:email])
    end
  end

  def group_ids
    self.groups.select('groups.id').map { |g| g.id }
  end

  protected

  # Checks whether a password is needed or not. For validations only.
  # Passwords are always required if it's a new record, or if the password
  # or confirmation are being set somewhere.
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
