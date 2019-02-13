require 'rails_helper'
require 'support/spec_test_helper'

RSpec.describe AdminsController, type: :controller do
  
  before(:all) do
    @admin = create(:admin)
  end

  describe "GET admin#index" do
      it "should list all the admins" do
        get :index
        expect(response).to render_template("index")
      end
  end
  
  describe "GET admin#edit" do
      it "should redirect to log in since we are not logged in" do
        get :edit, params: { id: @admin.id }
       expect(response).to redirect_to(new_session_path)
      end
      
      it "should login and go to the edit page" do
        login(@admin)
        get :edit, params: { id: @admin.id }
        expect(response).to render_template("edit")
      end
  end
  
  describe "PUT admin#update" do
    it "should redirect to the user path on succesful save" do
      login(@admin)
      post :update, :params => {:admin => {:name => 'New Admin', :password => 'password1!'}}
      expect(response).to redirect_to('/admin_account')
    end
  
    it "should render the edit screen again with errors if the model doesn't save" do
      login(@admin)
      post :update, :params => {:admin => {:name => 'New Admin', :password => 'wrong_password'}}
      expect(response).to redirect_to('/admin_account')
    end
  end
  
  describe "GET admin#new" do
    it "should go to the new page" do
      login(@admin)
      get :new
      expect(response).to render_template("new")
    end
  end
  
  describe "PUT admin#create" do
    it "should redirect to the user path on succesful save" do
      login(@admin)
      post :create, :params => {:admin => {:name => 'New Admin', :email => 'email@email.com', :password => 'password1!', :password_confirmation => 'password1!'}}
      expect(response).to redirect_to('/admins')
    end
  
    it "should render the new screen again with errors if the model doesn't save" do
      login(@admin)
      post :create, :params => {:admin => {:name => 'New Admin',:email => 'bad email', :password => 'password1!', :password_confirmation => 'password1!'}}
      expect(response).to redirect_to('/admins/new')
    end
  end
end
