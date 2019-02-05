require 'rails_helper'

RSpec.describe Email, type: :model do
  subject { 
    described_class.new(email: "test@test.com")
  }

  describe "Associations" do
    it { should have_and_belong_to_many :sections }
  end
 
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
   
    it "is not valid without a name" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
   
    it { should validate_length_of(:email).is_at_most(255).on(:create) }
    it { should validate_length_of(:email).is_at_most(255).on(:update) }
    it { should validate_uniqueness_of(:email) }
  end

end
