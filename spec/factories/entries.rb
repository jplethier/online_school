# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    classroom
    association(:resource, factory: :user)
  end
end
