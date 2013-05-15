# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Usuario teste'
    sequence(:email) { |n| "mail-#{n}@factory.com" }
    password '123qwe'
    password_confirmation '123qwe'

    account
  end

  factory :admin_user, parent: :user do
    admin true
  end
end
