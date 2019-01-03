require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject{Admin.new(name: "admin", email: "email", password: "password")}
  
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid without a email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end
end
