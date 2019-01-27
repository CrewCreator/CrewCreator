require 'rails_helper'
require 'support/spec_test_helper'

RSpec.describe StudentsController, type: :controller do
  
  before(:all) do
    @student = create(:student)
  end
  
  describe "GET student#new" do
    it "should go to the new page" do
      get :new
      expect(response).to render_template("new")
    end
  end
  
  describe "POST student#create" do
    it "should redirect to the user path on succesful save" do
      post :create, :params => {:student => {:name => 'New Student', :email => 'email@email.com', :password => 'password1!', :password_confirmation => 'password1!'}}
      expect(response).to redirect_to('/home')
    end
  
    it "should render the new screen again with errors if the model doesn't save" do
      post :create, :params => {:student => {:name => 'New Student',:email => 'bad email', :password => 'password1!', :password_confirmation => 'password1!'}}
      expect(response).to redirect_to('/createaccount')
    end
  end

end
