require 'rails_helper'

RSpec.describe SectionsController, type: :controller do
  before(:all) do 
    @course = create(:course)
  end 
  
  before(:each) do 
    admin = create(:admin)
    login(admin)
  end 
end
