FactoryBot.define do
  factory :student do
    name { "Student" }
    sequence(:email) { |n| "student#{n}@email.com" }
    password { "password1!" }
    password_confirmation { "password1!" }
  end
end