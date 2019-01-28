# spec/support/spec_test_helper.rb
module SpecTestHelper   
  def login_admin
    login(:admin)
  end

  def login(user)
    if user = Admin.find_by_email(user.email)
      session[:user_id] = user.id
      session[:is_admin] = true
    elsif user = Student.find_by_email(user.email)
      session[:user_id] = user.id
      session[:is_admin] = false
    end
  end

  def current_user
    if session[:is_admin] == true
      user = Admin.find(session[:user_id])
    elsif session[:is_admin] == false
      user = Student.find(session[:user_id])
    end
    return user
  end
end

# spec/spec_helper.rb
RSpec.configure do |config|
  config.include SpecTestHelper, :type => :controller
end