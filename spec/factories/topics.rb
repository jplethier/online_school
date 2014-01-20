# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    message 'F_TOPIC'

    account
    classroom
    user
  end
end
