# spec/support/spec_test_helper.rb
module SpecTestHelper   
  def login_admin
    login(:admin)
  end

  def login(admin)
    admin = Admin.find_by_email(admin.email)
    session[:user_id] = admin.id
  end

  def current_user
    Admin.find(session[:user_id])
  end
end

# spec/spec_helper.rb
RSpec.configure do |config|
  config.include SpecTestHelper, :type => :controller
end