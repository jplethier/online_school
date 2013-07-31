# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    ignore { confirmed true }

    account
    sequence(:email) { |n| "f-mail-#{n}@example.com" }
    name 'F_NAME'
    password 'F_PASSWORD'
  end

  factory :admin, parent: :user do
    admin true

    after(:create) do |user, evaluator|
      user.confirm! if evaluator.confirmed
    end
  end

  factory :student, parent: :user do
    student true

    after(:create) do |user, evaluator|
      user.confirm! if evaluator.confirmed
    end
  end
end
