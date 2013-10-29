# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student_exam do
    grade 1.5

    student
    exam
  end
end
