class Skill < ApplicationRecord
  has_and_belongs_to_many :projects
  
  validates :name, presence: {message: "Name cannot be empty"}, uniqueness: {message: "Skill already exists"}
end
