# This will guess the User class
FactoryBot.define do
  factory :admin do
    name { "Admin" }
    email  { "admin@admin.com" }
    password { "password1!" }
    password_confirmation { "password1!" }
  end
end