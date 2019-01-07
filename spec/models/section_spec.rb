require 'rails_helper'

RSpec.describe Section, type: :model do
  subject{
    described_class.new(number: 431)
  }
  
  describe "Validations" do
    it "is valid with valid attributes" do
      pending
      expect(subject).to be_valid
    end 
    
    it "is not valid without a section number" do 
      subject.number = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid with a section number greater than 4 digits long" do
      subject.number = 99999999999
      expect(subject).to_not be_valid
    end
    
    it "is not valid with a non-number" do 
      subject.number = "This is wrong"
      expect(subject).to_not be_valid
    end
    
    it "is valid with a section number 1-4 digits long" do
      pending
      subject.number = 1337
      expect(subject).to be_valid
    end
  end
end
