# spec/support/spec_test_helper.rb
module SpecTestHelper   
  def login_admin
    login(:admin)
  end

  def login(user)
    if Admin.find_by_email(user.email)
      session[:user_id] = user.id
      session[:user] = "admin"
    elsif Student.find_by_email(user.email)
      session[:user_id] = user.id
      session[:user] = "student"
    elsif Instructor.find_by_email(user.email)
      session[:user_id] = user.id
      session[:user] = "instructor"
    end
  end

  def current_user
    if session[:user] == "admin"
      user = Admin.find(session[:user_id])
    elsif session[:user] == "student"
      user = Student.find(session[:user_id])
    elsif session[:user] == "instructor"
      user = Instructor.find(session[:user_id])
    end
    return user
  end
end

# spec/spec_helper.rb
RSpec.configure do |config|
  config.include SpecTestHelper, :type => :controller
end