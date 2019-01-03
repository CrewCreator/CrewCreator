courses = [
{:name => 'Software Engineering', :code => 'CSCE 431', :description => 'Making software great again'},
{:name => 'Progamming Studio', :code => 'CSCE 315', :description => 'Agile project based programming'},
{:name => 'Software Security', :code => 'CSCE 489', :description => 'SaaS security and web routing'}
]

courses.each do |course|
  Course.create!(course)
end