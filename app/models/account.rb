# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  cnpj         :string(21)
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  contact_mail :string(255)
#  subdomain    :string(255)
#

class Account < ActiveRecord::Base
  ReservedSubdomains = %w( support suporte blog www help ajuda api minhasaladeaula admin dev test pop pop3 imap smtp ftp status escola e email mail webmail login signup staging homologacao launch start )

  validates :name, presence: true
  validates :contact_mail, presence: true
  validates :subdomain, presence: true, exclusion: { in: ReservedSubdomains }

  has_many :groups
  has_many :users
end
