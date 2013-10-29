# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam do
    period 20131
    kind "F_KIND"
    exam_date Time.new + 3.days

    classroom
  end
end
