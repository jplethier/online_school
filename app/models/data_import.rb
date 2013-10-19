class DataImport < ActiveRecord::Base
  has_attached_file :file, url: 'data_imports/:id_partition/:style.:extension',
    path: 'data_imports/:id_partition/:style.:extension'

  validates :file, attachment_presence: true
end
