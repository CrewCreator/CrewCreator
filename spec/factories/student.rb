FactoryBot.define do
  factory :student do
    name { "Student" }
    email  { "factory@test.com" }
    password { "password1!" }
    password_confirmation { "password1!" }
  end
end