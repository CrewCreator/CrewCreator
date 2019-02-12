require 'rails_helper'
require 'support/spec_test_helper'

RSpec.describe InstructorsController, type: :controller do
  before(:all) do
    @admin = create(:admin)
    @instructor = create(:instructor)
  end

  describe "GET instructor#index" do
      it "should list all the instructors" do
        login(@admin)
        get :index
        expect(response).to render_template("index")
      end
  end
  
  describe "GET instructor#new" do
    it "should go to new instructor page" do
      login(@admin)
      get :new
      expect(response).to render_template("new")
    end
  end
  
  describe "PUT instructor#create" do
    it "should make a new instructor with proper inputs" do
      login(@admin)
      post :create, params: {instructor: {name: 'New Instructor', email: 'prof@email.com', password: 'password1!', password_confirmation: 'password1!'}}
      expect(response).to redirect_to(instructors_path)
    end
    it "should redirect to new template if given bad email" do
      login(@admin)
      post :create, params: {instructor: {name: 'New Instructor', email: 'bad_email', password: 'password1!', password_confirmation: 'password1!'}}
      expect(response).to redirect_to(new_instructor_path)
    end
    it "should redirect to new template if given bad password" do
      login(@admin)
      post :create, params: {instructor: {name: 'New Instructor', email: 'prof@email.com', password: 'bad_password', password_confirmation: 'bad_password'}}
      expect(response).to redirect_to(new_instructor_path)
    end
    it "should redirect to new template if given different passwords" do
      login(@admin)
      post :create, params: {instructor: {name: 'New Instructor', email: 'prof@email.com', password: 'password1!', password_confirmation: 'password2!'}}
      expect(response).to redirect_to(new_instructor_path)
    end
  end
  
  describe "GET instructor#edit" do
    it "should render for admin" do
      login(@admin)
      get :edit, params: {id: "1"}
      expect(response).to render_template("edit")
    end
    it "should render for instructor's account" do
      login(@instructor)
      get :edit, params: {id: "1"}
      expect(response).to render_template("edit")
    end
    it "should redirect for different instructor" do
      other = create(:instructor)
      login(other)
      get :edit, params: {id: "1"}
      expect(response).to redirect_to(new_session_path)
    end
    it "should redirect for other users" do
      get :edit, params: {id: "1"}
      expect(response).to redirect_to(new_session_path)
      
      other = create(:student)
      login(other)
      get :edit, params: {id: "1"}
      expect(response).to redirect_to(new_session_path)
    end
  end
end
