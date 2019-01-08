class Skill < ApplicationRecord
  validates :name, presence: {message: "Name cannot be empty"}, uniqueness: {message: "skill already exists"}
  # validates :description, presence: true, message: "description cannot be empty"

end
