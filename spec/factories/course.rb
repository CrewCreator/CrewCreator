FactoryBot.define do
  factory :course do
    name { "Anything" }
    description { "Anything" }
    sequence(:code) { |n| "test-12#{n}" }
  end
end