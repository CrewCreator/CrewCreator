new_courses = [
{:name => 'Software Engineering', :code => 'CSCE 431', :description => 'Making software great again'},
{:name => 'Progamming Studio', :code => 'CSCE 315', :description => 'Agile project based programming'},
{:name => 'Software Security', :code => 'CSCE 489', :description => 'SaaS security and web routing'}
]

new_skills = [
    {:name=>"Javascript", :description=> "The language of the web"},
    {:name=>"Python", :description=> "Versatile scripting language that can possibly be used for Data Processing and Machine Learning"},
    {:name=>"Tensorflow", :description=> "One of the most popular Deep Learning libraries"},
    {:name=>"Scrum", :description=> "Awesome Project Management Framework for speedy project management"}
]

new_courses.each do |course|
  Course.create!(course)
end

base_admins = [
{:name => 'Admin', :email => 'admin@admin.com', :password => 'password1!'}
]

base_admins.each do |admin|
  Admin.create!(admin)
end