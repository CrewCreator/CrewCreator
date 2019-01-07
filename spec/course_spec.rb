require 'rails_helper'

describe Course, :type => :model do
  
  describe "Validations" do
    subject {Course.new(name: "Anything", code: "Anything", description: "Anything")}
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
    
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    
    it 'is not valid without a code' do
      subject.code = nil
      expect(subject).to_not be_valid
    end
    
    it 'is not valid without a description' do
      subject.description = nil
      expect(subject).to_not be_valid
    end
  end
end