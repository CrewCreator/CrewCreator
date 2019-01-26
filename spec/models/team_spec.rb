require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:project) { Project.new(name: "Anything", description: "Anything", difficulty: 3,
                    students_rated: 0, total_interest: 0) }
  subject {
    described_class.new(name: "Anything", version_control_link: "http://anything.com",
                        production_link: "http://anything.com", management_link: "http://anything.com",
                        scrum_location: "Anything", scrum_time: Date.new, project: project) 
  }

  describe "Associations" do
    it { should belong_to :project }
    #it { should have_and_belong_to_many :students }
  end
 
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
   
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  
    it "is be valid without a version_control_link" do
      subject.version_control_link = nil
      expect(subject).to be_valid
    end
  
    it "is be valid without a production_link" do
      subject.production_link = nil
      expect(subject).to be_valid
    end
    
    it "is be valid without a management_link" do
      subject.management_link = nil
      expect(subject).to be_valid
    end
  
    it "is be valid without a scrum_location" do
      subject.scrum_location = nil
      expect(subject).to be_valid
    end
    
    it "is be valid without a scrum_time" do
      subject.scrum_time = nil
      expect(subject).to be_valid
    end
    
    it { should validate_length_of(:name).is_at_most(60).on(:create) }
    it { should validate_length_of(:version_control_link).is_at_most(256).on(:create) }
    it { should validate_length_of(:production_link).is_at_most(256).on(:create) }
    it { should validate_length_of(:management_link).is_at_most(256).on(:create) }
    it { should validate_length_of(:scrum_location).is_at_most(60).on(:create) }
    
    it { should allow_value("").for(:version_control_link) }
    it { should allow_value("https://anything.com").for(:version_control_link) }
    it { should_not allow_value("anything").for(:version_control_link) }
    it { should allow_value("").for(:production_link) }
    it { should allow_value("https://anything.com").for(:production_link) }
    it { should_not allow_value("anything").for(:production_link) }
    it { should allow_value("").for(:management_link) }
    it { should allow_value("https://anything.com").for(:management_link) }
    it { should_not allow_value("anything").for(:management_link) }
  end
  
  describe "Class Functions" do
  end
end
