require 'rails_helper'

RSpec.describe Section, :type => :model do
  subject {
    described_class.new(number: 0, course: "CSCE 431",
                        projects: "Fitness Tracker, Capitalism Simulator",
                        moderators: "Nick, Jake", admin: "PCR", students: "Val, Valerie, Vick")
  }
  
  describe "Validations" do
    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end 
    
    it "is not valid without a section number" do
      subject.number = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid without a course" do
      subject.course = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid without projects" do
      subject.projects = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid without moderators" do
      subject.moderators = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid without an admin" do
      subject.admin = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid without students" do
      subject.students = nil
      expect(subject).to_not be_valid
    end
  end
end
