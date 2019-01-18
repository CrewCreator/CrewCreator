FactoryBot.define do
  #sequence :code do |n|
  #  "test-12#{n}"
  #end
  
  factory :course do
    name { "Anything" }
    description { "Anything" }
    sequence(:code) { |n| "test-12#{n}" }
    #code { "test-123" }
  end
end
