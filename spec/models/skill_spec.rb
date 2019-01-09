require 'rails_helper'

RSpec.describe Skill, :type => :model do
  it "is valid with valid attributes"
  it "is not valid without a name"

end

RSpec.describe Skill, :type => :model do
  subject {
    described_class.new(name: "Python")
  }

  describe "Associations" do
    it { should have_and_belong_to_many(:projects) }
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end


    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

end