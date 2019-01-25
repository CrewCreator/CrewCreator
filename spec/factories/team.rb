FactoryBot.define do
  factory :team do
    name { "Anything" }
    version_control_link { "Anything" }
    production_link { "Anything" }
    management_link { "Anything" }
    scrum_location { "Anything" }
    scrum_time { Date.new }
    project
  end
end