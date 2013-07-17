# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    title "Plano teste"
    students_number 5
    price 1.0
  end
end
