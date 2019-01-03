courses = [
{:name => 'Software Engineering', :code => 'CSCE 431', :decription => 'Making software great again'}
]

courses.each do |course|
  Course.create!(course)
end