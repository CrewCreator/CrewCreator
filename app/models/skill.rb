class Skill < ApplicationRecord
  has_and_belongs_to_many :projects
  accepts_nested_attributes_for :projects
  
  validates :name, presence: {message: "Name cannot be empty"}, uniqueness: {message: "skill already exists"}
  # validates :description, presence: true, message: "description cannot be empty"

end
