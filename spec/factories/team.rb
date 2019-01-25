FactoryBot.define do
  factory :team do
    name { "Anything" }
    version_control_link { "http://anything.com" }
    production_link { "http://anything.com" }
    management_link { "http://anything.com" }
    scrum_location { "http://anything.com" }
    scrum_time { Date.new }
    project
  end
end