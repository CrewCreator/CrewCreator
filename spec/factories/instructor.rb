FactoryBot.define do
  factory :instructor do
    name { "Professor" }
    sequence(:email) { |n| "prof#{n}@email.com" }
    password { "password1!" }
    password_confirmation { "password1!" }
  end
end