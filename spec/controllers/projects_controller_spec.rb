require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before(:all) do
    @section = create(:section)
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
    
    it "redirect to new project page" do
      expect(response).to redirect_to(new_section_project_path)
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
    
    it "redirect to edit project page" do
      expect(response).to redirect_to(edit_project_path)
    end
    
    it "assigns @project" do
      expect(assigns(:project)).to eq(@project)
    end
  end

  describe "POST #create" do
    it "redirect to projects page" do
      atr = attributes_for(:project)
      post :create, params: { section_id: @section.id, project: atr }
      expect(response).to redirect_to(section_projects_path)
    end
  end

  describe "POST #update" do
    it "redirect to projects page" do
      project = create(:project)
      post :update, params: {:id => project.id }
      expect(response).to redirect_to(section_projects_path)
    end
  end
  
  describe "POST #destroy" do
    it "redirect to projects page" do
      project = create(:project)
      post :destroy, params: { id: project.id }
      expect(response).to redirect_to(section_projects_path)
    end
  end

end
