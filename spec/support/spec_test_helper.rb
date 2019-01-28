# spec/support/spec_test_helper.rb
module SpecTestHelper   
  def login_admin
    login(:admin)
  end

  def login(user)
    user = Admin.find_by_email(user.email)
    if !user
      user = Student.find_by_email(user.email)
    end
    if user
      session[:user_id] = user.id
    end
  end

  def current_user
    user = Admin.find(session[:user_id])
    if !user
      user = Student.find(session[:user_id])
    end
    return user
  end
end

# spec/spec_helper.rb
RSpec.configure do |config|
  config.include SpecTestHelper, :type => :controller
end