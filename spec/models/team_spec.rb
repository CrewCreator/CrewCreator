require 'rails_helper'

RSpec.describe Team, type: :model do
  subject{Team.new(name: "Crew Creator", description: "The best team ever wahahahaahahahahahahhahaa", project_management_link: "www.pivotaltracker.com",
                   version_control_link: "www.github.com",
                   staging_link: "www.herokuapp.com/staging",
                   production_link:"www.herokuapp.com/production")}

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

  it "is not valid if description is too long" do
    subject.description = "a" * 501
    expect(subject).to_not be_valid
  end

  it "is not valid if description is too short" do
    subject.description = "short message"
    expect(subject).to_not be_valid
  end

  it "is not valid if links is improper format" do
    subject.staging_link = "aaaaaaaaaaaaaaaa"
    expect(subject).to_not be_valid
  end
# TODO: Add test to guard against duplicate team names
end