require 'rails_helper'
require 'support/spec_test_helper'

describe CoursesController, type: :controller do

  before(:each) do
    admin = create(:admin)
    login(admin)
  end
  
  before(:all) do
    @course = create(:course)
  end
  
  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  
  describe "POST #create" do
    it "expects http redirect on success" do
      get :create, :params => {:course => {:code => "xxx-123", :name => "Anything", :description => "Anything"}, :section => {:number => "501"}}
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(courses_path)
    end
    
    it "rerenders page on failure" do
      get :create, :params => {:course => {:code => "BadCode", :name => "Anything", :description => "Anything"}, :section => {:number => "501"}}
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET #show" do
    it "renders show template" do
      pending "Show not implemented"
      get :show, :id => "1"
      expect(response).to render_template("courses/1")
    end
  end
  
  describe "GET #edit" do
    it "renders edit template" do
      get :edit, :params => {:id => "1"}
      expect(response).to render_template("courses/edit")
    end
  end
  
  describe "POST #update" do
    it "expects http redirect on success" do
      post :update, :params => {:course => {:code => "CSCE-431", :name => "Software Engineering", :description => "Making software great again!"}, :id => "1"}
      expect(response).to have_http_status(:redirect)
    end
  end
  
  describe "GET #remove" do
    it "renders remove template" do
      get :remove, :params => {:id => "1"}
      #expect(response).to render_template("remove")
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "POST #destroy" do
    it "expects http success" do
      post :destroy, :params => {:id => "1", :admin => {:id => "1"}}
      expect(response).to have_http_status(:redirect)
    end
  end
  
end
