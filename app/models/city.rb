# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  uf         :string(2)
#  created_at :datetime
#  updated_at :datetime
#

class City < ActiveRecord::Base
  validates :name, presence: true
  validates :uf,   presence: true
end
