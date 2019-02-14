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
  
  describe "POST instructor#update" do
    it "should redirect for different instructor" do
      other = create(:instructor)
      login(other)
      post :update, params: {id: "1", instructor: {name: "Any", email: "any@any.com", password: "password1!"}}
      expect(response).to redirect_to(new_session_path)
    end
    it "should redirect for other user" do
      post :update, params: {id: "1", instructor: {name: "Any", email: "any@any.com", password: "password1!"}}
      expect(response).to redirect_to(new_session_path)
    end
    it "should let admins update with correct password and edits" do
      login(@admin)
      post :update, params: {id: "1", instructor: {name: "Any", email: "any@any.com", password: "password1!"}}
      expect(response).to redirect_to(instructors_path)
    end
    it "should not let admins update with incorrect password and edits" do
      login(@admin)
      post :update, params: {id: "1", instructor: {name: "Any", email: "any@any.com", password: "bad_password!"}}
      expect(response).to redirect_to(edit_instructor_path("1"))
      post :update, params: {id: "1", instructor: {name: "Any", email: "bad_email", password: "password1!"}}
      expect(response).to redirect_to(edit_instructor_path(1))
      post :update, params: {id: "1", instructor: {name: "", email: "any@any.com", password: "password1!"}}
      expect(response).to redirect_to(edit_instructor_path(1))
    end
    it "should let same instructor update with correct password and edits"  do
      login(@instructor)
      post :update, params: {id: "1", instructor: {name: "Any", email: "any@any.com", password: "password1!"}}
      expect(response).to redirect_to(edit_instructor_path(1))
    end
    it "should not let same instructor update with incorrect password and edits" do
      login(@instructor)
      post :update, params: {id: "1", instructor: {name: "Any", email: "any@any.com", password: "bad_password!"}}
      expect(response).to redirect_to(edit_instructor_path(1))
      post :update, params: {id: "1", instructor: {name: "Any", email: "bad_email", password: "password1!"}}
      expect(response).to redirect_to(edit_instructor_path(1))
      post :update, params: {id: "1", instructor: {name: "", email: "any@any.com", password: "password1!"}}
      expect(response).to redirect_to(edit_instructor_path(1))
    end
  end
  
  describe "GET instructor#remove" do
    it "should render for admin" do
      login(@admin)
      get :remove, params: {id: "1"}
      expect(response).to render_template("remove")
    end
    it "should render for instructor's account" do
      login(@instructor)
      get :remove, params: {id: "1"}
      expect(response).to render_template("remove")
    end
    it "should redirect for different instructor" do
      other = create(:instructor)
      login(other)
      get :remove, params: {id: "1"}
      expect(response).to redirect_to(new_session_path)
    end
    it "should redirect for other users" do
      get :remove, params: {id: "1"}
      expect(response).to redirect_to(new_session_path)
      
      other = create(:student)
      login(other)
      get :remove, params: {id: "1"}
      expect(response).to redirect_to(new_session_path)
    end
  end
  
  describe "POST instructor#destroy" do
    it "should not delete instructor is user does not have admin access" do
      other = create(:student)
      post :destroy, params: {id: "1", instructor: {id: "1", password: "password1!"}}
      expect(response).to redirect_to(new_session_path)
      login(other)
      post :destroy, params: {id: "1", instructor: {id: "1", password: "password1!"}}
      expect(response).to redirect_to(new_session_path)
    end
    it "should delete instructor if user is an admin with correct password" do
      login(@admin)
      post :destroy, params: {id: "1", instructor: {id: "1", password: "password1!"}}
      expect(response).to redirect_to(instructors_path)
    end
    it "should not delete instructor if user is an admin with incorrect password" do
      login(@admin)
      post :destroy, params: {id: "1", instructor: {id: "1", password: "bad_password!"}}
      expect(response).to redirect_to(remove_instructor_path("1"))
    end
    it "should delete instructor if user is that instructor with correct password" do
      login(@instructor)
      post :destroy, params: {id: "1", instructor: {id: "1", password: "password1!"}}
      expect(response).to redirect_to(home_path)
    end
    it "should not delete instructor if user is that instructor with incorrect password" do
      login(@instructor)
      post :destroy, params: {id: "1", instructor: {id: "1", password: "bad_password!"}}
      expect(response).to redirect_to(remove_instructor_path("1"))
    end
    it "should not delete instructor if user is an instructor but not the same instructor" do
      other = create(:instructor)
      login(other)
      post :destroy, params: {id: "1", instructor: {id: "1", password: "bad_password!"}}
      expect(response).to redirect_to(new_session_path)
    end
  end
end
