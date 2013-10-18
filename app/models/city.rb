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

  scope :uf_list, lambda { select('distinct uf').order(:uf) }
  scope :name_list, lambda { |uf| select(:name).where(uf: uf).order(:name) }
end
