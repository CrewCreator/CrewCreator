require 'rails_helper'
require 'support/spec_test_helper'

RSpec.describe SectionsController, type: :controller do
  before(:all) do 
    @course = create(:course)
  end 
  
  before(:each) do 
    admin = create(:admin)
    login(admin)
  end 
  
  #describe "GET #index" do 
  #  it "renders index template" do 
  #    get :index
  #    expect(response).to render_template("index")
  #  end 
  #end 
  
  describe "GET #new" do 
    before(:each) do 
      get :new, params: { course_id: @course.id }
    end 
    
    it "renders new template" do 
      expect(response).to render_template("new")
    end 
  end 
  
  describe "GET #edit" do 
    before(:each) do 
      @section = create(:section)
      get :edit, params: { id: @section.id }
    end 
    
    it "renders edit template" do 
      expect(response).to render_template("edit")
    end 
    
    it "status for edit section page" do 
      expect(response).to have_http_status(:success)
    end 
    
    it "assigns @section" do 
      expect(assigns(:section)).to eq(@section)
    end 
  end 
  
  describe "POST #create" do 
    it "redirect to courses page on success" do 
      atr = attributes_for(:section)
      post :create, params: { course_id: @course.id, section: atr }
      expect(response).to redirect_to(courses_path)
    end 
    
    it "redirect to new section page on failure" do 
      atr = attributes_for(:section, number: nil)
      post :create, params: { course_id: @course.id, section: atr }
      expect(response).to render_template("new")
    end 
  end 
  
  describe "PUT #update" do 
    before(:each) do 
      @section = create(:section)
    end 
    
    it "redirects to projects page for section" do 
      atr = attributes_for(:section)
      put :update, params: { :id => @section.id, section: atr }
      expect(response).to redirect_to(section_projects_path(@section.id))
    end 
    
    it "have status direct" do 
      atr = attributes_for(:section)
      put :update, params: { :id => @section.id, section: atr }
      expect(response).to have_http_status(:redirect)
    end 
    
    it "render to edit section page upon failure" do 
      atr = attributes_for(:section, number: nil)
      put :update, params: { :id => @section.id, section: atr }
      expect(response).to render_template("edit")
    end
  end
  
  describe "GET #remove" do 
    before(:each) do 
      @section = create(:section)
    end
    
    it "expects http success" do
      get :remove, params: { :id => @section.id }
      expect(response).to have_http_status(:success)
    end 
  end
  
  describe "POST #destroy" do 
    before(:each) do 
      @section = create(:section)
    end
    
    it "expects http success" do
      get :remove, params: { :id => @section.id, :admin => {:id => "1" }}
      expect(response).to have_http_status(:success)
    end 
  end
  
end
