require "rails_helper"

RSpec.describe Project, :type => :model do
  subject { 
    described_class.new(name: "Anything", description: "Anything", difficulty: 3,
                        students_rated: 0, total_interest: 0) 
  }

  describe "Associations" do
    #it { should have_many :teams }
    #it { should have_many :skills }
    #it { should belongs_to :challenge }
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
  
    it "is not valid without a difficulty" do
      subject.difficulty = nil
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
    
    it { should validate_length_of(:name).is_at_most(60).on(:create) }
    it { should validate_length_of(:description).is_at_most(65535).on(:create) }
    
    it { should validate_numericality_of(:difficulty).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5).only_integer }
    it { should validate_numericality_of(:students_rated).only_integer }
    it { should validate_numericality_of(:total_interest).only_integer }
  end
  
  describe "Class Functions" do
    it "difficulties should return five difficulties" do
      expect(Project.difficulties).to eq([1, 2, 3, 4, 5]) 
    end
  end

end
