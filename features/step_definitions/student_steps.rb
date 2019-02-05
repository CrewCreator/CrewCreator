Given /^(?:|I )am not logged in$/ do
  visit('/logout')
end

Given /^(?:|I )have a student account$/ do
  Student.create(name: "Joe", email: "student@email.com", password: "password1!")
end

Given /^(?:|I )have an account with name "(.*)" and email "(.*)" and password "(.*)"$/ do |name, email, password|
  Student.create(name: name, email: email, password: password)
end

Given /^Section "(.*)" for course "(.*)" has student "(.*)" on the roster$/ do |section, course, student|
  section = Course.find_by_code(course).sections.find_by_number(section)
  email = Email.find_by_email(student)
  if email
    section.emails << email
  else
    email = Email.create!(email: student)
    section.emails << email
    email.save
  end
  section.save
end

When /^(?:|I )update student "(.*)" with name "(.*)" and email "(.*)"$/ do |student, name, email|	
  Student.update(Student.find_by_email(student).id, name: name, email: email, password: "password1!")
end	