require 'rails_helper'
require 'support/spec_test_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "assigns @sections as admin" do
      admin = create(:admin)
      login(admin)
      get :index
      expect(assigns(:sections)).to eq(Section)
    end
    
    it "assigns @sections as admin" do
      student = create(:student)
      login(student)
      section = create(:section)
      student.sections << section
      get :index
      expect(assigns(:sections)).to eq([section])
    end
  end
  
end
