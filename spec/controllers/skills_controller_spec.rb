require 'rails_helper'

RSpec.describe SkillsController, type: :controller do

  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    it "expect http redirect" do
      get :create, :params => {:skill => {:name => "Anything", :description => "Anything"}}
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST #destroy" do
    it "expect http redirect" do
      pending
      skill = Skill.create
      post :destroy, :params => {:id => skill.id}
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #new" do
    it "renders new template" do
      pending "Requires Admin login"
      get :new
      expect(response).to render_template("new")
    end
  end
  
  describe "GET #edit" do
    it "renders edit template" do
      pending
      get :edit
      expect(response).to render_template("edit")
    end
  end
  
  describe "GET #show" do
    it "renders show template" do
      pending
      get :show
      expect(response).to render_template("show")
    end
  end
  
  describe "POST #update" do
    it "expect http redirect" do
      pending
      skill = Skill.create
      post :update, :params => {:id => skill.id, :skill => {:name => "Anything", :description => "Anything"}}
      expect(response).to have_http_status(:redirect)
    end
  end

end
