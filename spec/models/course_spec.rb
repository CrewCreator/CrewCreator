require 'rails_helper'

describe Course, :type => :model do
   subject {Course.new(name: "Anything", code: "any-1234", description: "Anything")}
  describe "Validations" do
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
    
    it 'is not valid wiht invalid code' do
      subject.code = "blah"
      expect(subject).to_not be_valid
    end
    
    it 'is not valid with invalid description' do
      subject.description = "character"*400
      expect(subject).to_not be_valid
    end
       
    it 'is not valid with invalid name' do
      subject.name = "me"*76
      expect(subject).to_not be_valid
    end 
  end
  
  describe "Associations" do
    it { should have_many(:sections).dependent(:delete_all) }
    it { should have_many(:projects).through(:sections) }
  end
end