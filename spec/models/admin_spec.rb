require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject{Admin.new(name: "admin", email: "email@email.com", password: "password1!", password_confirmation: "password1!")}
  
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
  
  it "is not valid if password is missing a digit" do
    subject.password = "aaaaaaaaaaaaaaaa12345"
    expect(subject).to_not be_valid
  end
  
  it "is not valid if password is missing a symbol" do
    subject.password = "123456789"
    expect(subject).to_not be_valid
  end
  
  it "is not valid if name is too long" do
    subject.name = "a" * 51
    expect(subject).to_not be_valid
  end
  
  it "is not valid if email is too long" do
    subject.email = "a@tamu.edu" * 26
    expect(subject).to_not be_valid
  end
  
  it "is not valid if email is improper format" do
    subject.email = "aaaaaaaaaaaaaaaa"
    expect(subject).to_not be_valid
  end
  
  it "is not valid if duplicate emails" do
    subject_two = Admin.new(name: "admin", email: "email@email.com", password: "password", password_confirmation: "password")
    subject.save
    subject_two.save
    expect(subject_two).to_not be_valid
  end
  
  it "emails should be saved as lowecase" do
    mixed_case_email = "AsDfGh@GmAiL.CoM"
    subject.email = mixed_case_email
    subject.save
    expect(mixed_case_email.downcase).to eq(subject.reload.email)
  end
  
  it "password must match password_confirmation" do
    subject.password = "newpassword"
    expect(subject).to_not be_valid
  end
  
  it "password must be greater than 8 characters" do
    subject.password = "1234"
    subject.password_confirmation = "1234"
    expect(subject).to_not be_valid
  end
  
  describe "Associations" do
    #it { should have_many(:sections) }
  end
end
