require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before(:all) do
    @section = create(:section)
  end
  
  before(:each) do
    admin = create(:admin)
    login(admin)
  end

  describe "GET #index" do
    it "renders index template" do
      get :index, params: { section_id: @section.id }
      expect(response).to render_template("index")
    end
    
    it "assigns @projects" do
      project = create(:project, section: @section)
      get :index, params: { section_id: @section.id }
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe "GET #new" do
    before(:each) do
      get :new, params: { section_id: @section.id }
    end
    
    it "renders new template" do
      expect(response).to render_template("new")
    end
    
    it "assigns project to a new Project" do
      expect(assigns(:project)).to be_a_new(Project)
    end
  end
  
  describe "GET #edit" do
    before(:each) do
      @project = create(:project)
      get :edit, params: { id: @project.id }
    end
    
    it "renders edit template" do
      expect(response).to render_template("edit")
    end
    
    it "status for edit project page" do
      expect(response).to have_http_status(:success)
    end
    
    it "assigns @project" do
      expect(assigns(:project)).to eq(@project)
    end
  end

  describe "POST #create" do
    it "redirect to projects page on success" do
      atr = attributes_for(:project)
      post :create, params: { section_id: @section.id, project: atr }
      expect(response).to redirect_to(section_projects_path)
    end
    
    it "render to new project page on failure" do
      atr = attributes_for(:project, name: nil)
      post :create, params: { section_id: @section.id, project: atr }
      expect(response).to render_template("new")
    end
  end

  describe "PUT #update" do
    before(:each) do
      @project = create(:project)
    end
    
    it "redirect to projects page" do
      atr = attributes_for(:project)
      put :update, params: { :id => @project.id, project: atr }
      expect(response).to redirect_to(section_projects_path(@project.section.id))
    end
    
    it "have status redirect" do
      atr = attributes_for(:project)
      put :update, params: { :id => @project.id, project: atr }
      expect(response).to have_http_status(:redirect)
    end
    
    it "render to edit project page on failure" do
      atr = attributes_for(:project, name: nil)
      put :update, params: { :id => @project.id, project: atr }
      expect(response).to render_template("edit")
    end
  end

end
