Given /^(?:|I )am not logged in$/ do
  visit('/logout')
end

Given /^(?:|I )have a student account$/ do
  Student.create(name: "Joe", email: "student@email.com", password: "password1!")
end

Given /^(?:|I )have an account with name "(.*)" and email "(.*)" and password "(.*)"$/ do |name, email, password|
  Student.create(name: name, email: email, password: password)
end