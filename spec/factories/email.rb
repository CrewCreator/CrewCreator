FactoryBot.define do
  factory :email do
    sequence(:code) { |n| "test@test#{n}.com" }
  end
end
