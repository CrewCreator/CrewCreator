require 'rails_helper'
require 'support/spec_test_helper'

RSpec.describe TeamsController, type: :controller do
  before(:each) do
    @admin = create(:admin)
    login(@admin)
  end
  
  describe "GET #index" do
    before(:each) do
      @section = create(:section)
      @project = create(:project, section: @section)
    end
    
    it "renders index template" do
      get :index, params: { section_id: @section.id }
      expect(response).to render_template("index")
    end
    
    it "assigns @projects" do
      team = create(:team, project: @project)
      get :index, params: { section_id: @section.id }
      expect(assigns(:teams)).to eq([team])
    end
  end
  
  describe "GET #show" do
    before(:each) do
      @team = create(:team)
      get :show, params: { id: @team.id }
    end
    
    it "renders show template" do
      expect(response).to render_template("show")
    end
    
    it "assigns team to @team" do
      expect(assigns(:team)).to eq(@team)
    end
  end

  describe "GET #new" do
    before(:each) do
      @project = create(:project)
      get :new, params: { project_id: @project.id }
    end
    
    it "renders new template" do
      expect(response).to render_template("new")
    end
    
    it "assigns team to a new Team" do
      expect(assigns(:team)).to be_a_new(Team)
    end
  end
  
  describe "GET #edit" do
    before(:each) do
      @team = create(:team)
      get :edit, params: { id: @team.id }
    end
    
    it "renders edit template" do
      expect(response).to render_template("edit")
    end
    
    it "status for edit team page" do
      expect(response).to have_http_status(:success)
    end
    
    it "assigns @team" do
      expect(assigns(:team)).to eq(@team)
    end
  end

  describe "POST #create" do
    before(:each) do
      @project = create(:project)
    end
    
    it "redirect to projects page on successful creation of team" do
      atr = attributes_for(:team)
      post :create, params: { project_id: @project.id, team: atr }
      expect(response).to redirect_to(section_projects_path(@project.section))
    end
    
    it "render to new team page on failure" do
      atr = attributes_for(:team, name: nil)
      post :create, params: { project_id: @project.id, team: atr }
      expect(response).to render_template("new")
    end
  end

  describe "PUT #update" do
    before(:each) do
      @team = create(:team)
    end
    
    it "redirect to team show page after updating team" do
      atr = attributes_for(:team)
      put :update, params: { id: @team.id, team: atr }
      expect(response).to redirect_to(team_path)
    end
    
    it "have status redirect" do
      atr = attributes_for(:team)
      put :update, params: { id: @team.id, team: atr }
      expect(response).to have_http_status(:redirect)
    end
    
    it "render to edit team page on failure" do
      atr = attributes_for(:team, name: nil)
      put :update, params: { id: @team.id, team: atr }
      expect(response).to render_template("edit")
    end
  end
  
  describe "GET #remove" do
    it "renders remove template" do
      @team = create(:team)
      get :remove, params: {id: @team.id}
      expect(response).to render_template("remove")
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "POST #destroy" do
    before(:each) do
      @team = create(:team)
    end
    
    it "expects http success" do
      post :destroy, params: {id: @team.id, admin: {id: @admin.id, password: @admin.password}}
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(section_projects_path(@team.project.section))
    end
    
    it "expects redirect to remove page with wrong password" do
      post :destroy, params: {id: @team.id, admin: {id: @admin.id, password: "wrong_password"}}
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(remove_team_path)
    end
  end

end
