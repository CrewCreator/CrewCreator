courses = [
{name: 'Software Engineering', code: 'CSCE-431', description: 'Making software great again'},
{name: 'Progamming Studio', code: 'CSCE-315', description: 'Agile project based programming'},
{name: 'Software Security', code: 'CSCE-489', description: 'SaaS security and web routing'}
]

sections = [
  {number: '501'},
  {number: '502'},
  {number: '503'},
  {number: '504'},
  {number: '505'},
  {number: '506'}
]

projects = [
  {name: "Project Team Matchmaker", description: "Ruby on Rails app for matching team with projects", difficulty: "4", students_rated: "0", total_interest: "0"},
  {name: "New Reddit", description: "Better reddit hoepfully with search", difficulty: "4", students_rated: "0", total_interest: "0"}
]

teams = [
  {name: "CrewCreator"},
  {name: "New New Pied Piper"},
  {name: "Sling"}
]

skills = [
    {:name=>"Javascript", :description=> "The language of the web"},
    {:name=>"Python", :description=> "Versatile scripting language that can possibly be used for Data Processing and Machine Learning"},
    {:name=>"Tensorflow", :description=> "One of the most popular Deep Learning libraries"},
    {:name=>"Scrum", :description=> "Awesome Project Management Framework for speedy project management"}
]

base_admins = [
{:name => 'Admin', :email => 'admin@admin.com', :password => 'password1!'}
]

courses.each do |course|
  Course.create!(course)
end

skils.each do |skill|
  Skill.create!(skill)
end

[0, 1, 2].each do |i|
  course = Course.find(i)
  course.sections.create!(sections[i])
end

sections[3..(sections.size-1)].each do |section|
  course = Course.find(1+rand(courses.size))
  course.sections.create!(section)
end

project.each do |project|
  section = Section.find(1+rand(sections.size))
  project = section.project.create!(project)
  (0..(skils.size-1)).to_a.each do |i|
    project.skills << Skill.find(1+rand(i))
  end
end

team.each do |team|
  project = Project.find(1+rand(projects.size))
  project.teams.create!(team)
end

base_admins.each do |admin|
  Admin.create!(admin)
end