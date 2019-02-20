FactoryBot.define do
  factory :section do
    sequence(:number) { |n| "12#{n}" }
    semester { "Fall" }
    year { 2019 }
    course
  end
end
