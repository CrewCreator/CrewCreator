Given /^(?:|I )am logged in as an instructor$/ do
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