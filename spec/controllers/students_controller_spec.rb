require 'rails_helper'
require 'support/spec_test_helper'

RSpec.describe StudentsController, type: :controller do
  
  before(:all) do
    @student = create(:student)
    @admin = create(:admin)
  end
  
  describe "GET student#index" do
      it "should redirect to login" do
        get :index
        expect(response).to redirect_to(new_session_path)
      end
      
      it "should redirect to login since we are not an admin" do
        login(@student)
        get :index
        expect(response).to redirect_to(new_session_path)
      end
      
      it "you should be able to view all students since you are an admin" do
        login(@admin)
        get :index
        expect(response).to render_template("index")
      end
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
  
  describe "GET students#edit" do
      it "should redirect to log in since we are not logged in" do
       get :edit
       expect(response).to redirect_to(new_session_path)
      end
      
      it "should login and go to the edit page" do
        login(@student)
        get :edit
        expect(response).to render_template("edit")
      end
  end

end
