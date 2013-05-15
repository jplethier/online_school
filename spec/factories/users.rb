# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "f-mail-#{n}@example.com" }
    name 'F_NAME'
    password 'F_PASSWORD'

    account
  end

  factory :admin_user, parent: :user do
    admin true
  end
end
