require "rails_helper"

RSpec.describe Project, :type => :model do
  subject { 
    described_class.new(name: "Anything", description: "Anything",
                        students_rated: 0, total_interest: 0) 
  }

  describe "Associations" do
     
  end
 
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
   
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without a description" do
      subject.description = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without a students_rated" do
      subject.students_rated = nil
      expect(subject).to_not be_valid
    end
  
    it "is not valid without a total_interest" do
      subject.total_interest = nil
      expect(subject).to_not be_valid
    end
  end
  
end