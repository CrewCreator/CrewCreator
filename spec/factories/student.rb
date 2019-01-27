FactoryBot.define do
  factory :student do
    name { "Stdudent" }
    email  { "test@test.com" }
    password { "password1!" }
    password_confirmation { "password1!" }
  end
end