# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  cnpj       :string(21)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Account < ActiveRecord::Base
  #attr_accessible :cnpj, :name

  validates :cnpj, presence: true
  validates :name, presence: true

  has_many :users
end