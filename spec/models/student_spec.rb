require 'rails_helper'

RSpec.describe Student, type: :model do
  subject{Student.new(name: "student", email: "student@email.com", password: "password1!", password_confirmation: "password1!")}
  
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
  
  it "is not valid if password is missing a symbol" do
    subject.password = "aaaaaaaaaaaaaaaa12345"
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
  
  it "emails should be saved as lowecase" do
    mixed_case_email = "AsDfGh@GmAiL.CoM"
    subject.email = mixed_case_email
    subject.save
    expect(mixed_case_email.downcase).to eq(subject.reload.email)
  end
  
  it "password must match password_confirmation" do
    subject.password = "newpassword3!"
    expect(subject).to_not be_valid
  end
  
  it "password must be greater than 8 characters" do
    subject.password = "1234"
    subject.password_confirmation = "1234"
    expect(subject).to_not be_valid
  end
  
  it "is not valid if email is taken by another student" do
    subject_two = Student.new(name: "student", email: "student@email.com", password: "password1!", password_confirmation: "password1!")
    subject.save
    subject_two.save
    expect(subject_two).to_not be_valid
  end
  
  it "not valid if email is taken by an admin" do
    admin_with_same_email = Admin.new(name: "admin", email: "nonunique@email.com", password: "password1!", password_confirmation: "password1!")
    admin_with_same_email.save
    subject.email = 'nonunique@email.com'
    subject.save
    expect(subject).to_not be_valid
  end
  
end
