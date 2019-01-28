FactoryBot.define do
  factory :admin do
    name { "Admin" }
    sequence(:email) { |n| "admin#{n}@admin.com" }
    password { "password1!" }
    password_confirmation { "password1!" }
  end
end