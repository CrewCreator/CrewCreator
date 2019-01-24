require 'rails_helper'

RSpec.describe Section, type: :model do
  let(:course) { Course.new(name: "Anything", code: "any-1234", description: "Anything") }
  subject{
    described_class.new(number: 501, semester: "Spring", year: 2019, :course => course)
  }
  
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end 
    
    it "is not valid without a section number" do 
      subject.number = nil
      subject.semester = nil
      subject.year = nil
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
      subject.number = 1337
      expect(subject).to be_valid
    end
    
    it "is not valid with a non-unique section number in the same term" do 
      subject_two = Section.new(number: 501, semester: "Spring", year: 2019, :course => course)
      subject.save
      subject_two.save
      expect(subject_two).to_not be_valid
    end
    
    it "is valid with a unique section number in the same term" do 
      subject_two = Section.new(number: 502, semester: "Spring", year: 2019, :course => course)
      subject.save
      subject_two.save
      expect(subject_two).to be_valid
    end
    
    it "is valid with the same section number in a different semester in the same year" do 
      subject_two = Section.new(number: 501, semester: "Fall", year: 2019, :course => course)
      subject.save
      subject_two.save
      expect(subject_two).to be_valid
    end 
    
    it "is valid with the same section number in the same semester in a different year" do 
      subject_two = Section.new(number: 501, semester: "Spring", year: 2020, :course => course)
      subject.save
      subject_two.save
      expect(subject_two).to be_valid
    end
  end
  
  describe "Associations" do
    it { should belong_to(:course).touch(:true).autosave(:true).validate(:true) }
    #it { should belong_to(:admin) }
    it { should have_many(:projects).dependent(:delete_all) }
  end
end
