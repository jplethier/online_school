class City < ActiveRecord::Base
  validates :name, presence: true
  validates :uf,   presence: true
end
