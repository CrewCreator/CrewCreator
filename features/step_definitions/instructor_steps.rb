Given /^(?:|I )am logged in as an instructor$/ do
  visit('/logout')
  Instructor.create(name: "Prof", email: "prof@email.com", password: "password1!")
  visit("/sessions/new")
  fill_in("Email", with: "prof@email.com")
  fill_in("Password", with: "password1!")
  click_button("Login")
end

Given /^(?:|I )have an instructor account$/ do
  Instructor.create(name: "Prof", email: "prof@email.com", password: "password1!")
end

Given /^(?:|I )have an instructor account with name "(.*)" and email "(.*)" and password "(.*)"$/ do |name, email, password|
  Instructor.create(name: name, email: email, password: password)
end

Given /^Instructor "(.*)" has made section "(.*)" for course "(.*)"$/ do |email, number, code|
  course = Course.find_by_code(code)
  instructor = Instructor.find_by_email(email)
  if course == nil
    course = Course.create!(name: "Default", code: code, description: "anything")
  end
  section = course.sections.create!(number: number, year: "2019", semester: "Spring")
  instructor.sections << section
end