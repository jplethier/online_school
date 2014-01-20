# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    message "F_POST"

    topic
    account
    user
  end
end
