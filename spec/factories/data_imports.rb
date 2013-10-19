FactoryGirl.define do
  factory :data_import do
    file_file_name    { 'test.pdf' }
    file_content_type { 'application/pdf' }
    file_file_size    { 1024 }
  end

  factory :real_data_import, parent: :data_import do
    file { File.new("#{Rails.root}/app/assets/images/small_logo.png") }
  end
end
