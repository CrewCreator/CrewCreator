require 'rails_helper'
require 'support/spec_test_helper'

RSpec.describe SkillsController, type: :controller do
  
  before(:all) do
    @skill = create(:skill)
  end
  
  before(:each) do
    admin = create(:admin)
    login(admin)
  end

  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    it "expect http redirect" do
      get :create, params: {skill: {name: "Anything", description: "Anything"}}
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #destroy" do
    it "expect http redirect" do
      post :destroy, params: {id: @skill.id}
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  
  describe "GET #edit" do
    it "renders edit template" do
      get :edit, params: {id: @skill.id}
      expect(response).to render_template("edit")
    end
  end
  
  describe "POST #update" do
    it "expect http redirect" do
      skill = Skill.create
      post :update, params: {id: @skill.id, skill: {name: "Anything", description: "Anything"}}
      expect(response).to have_http_status(:redirect)
    end
  end

end
