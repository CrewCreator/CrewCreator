require 'rails_helper'

RSpec.describe Section, type: :model do
  subject{
    described_class.new(number: 431)
  }
  
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end 
    
    it "is not valid without a section number" do 
      subject.number = nil
      expect(subject).to_not be_valid
    end
  end
end
