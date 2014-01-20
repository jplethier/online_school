# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry_settings do
    follow false

    entry
    topic
  end
end
