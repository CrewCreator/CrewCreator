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

  describe "POST #create" do
    it "expect http redirect" do
      atr = attributes_for(:project)
      post :create, params: { section_id: @section.id, project: atr }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST #destroy" do
    it "expect http redirect" do
      project = create(:project)
      post :destroy, params: { id: project.id }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { section_id: @section.id }
      expect(response).to have_http_status(:redirect)
    end
  end
  
  describe "GET #edit" do
    it "renders edit template" do
      project = create(:project)
      get :edit, params: { id: project.id }
      expect(response).to render_template("edit")
    end
  end
  
  describe "POST #update" do
    it "expect http redirect" do
      project = create(:project)
      post :update, params: {:id => project.id }
      expect(response).to have_http_status(:redirect)
    end
  end

end
