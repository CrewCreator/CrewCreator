class Team < ApplicationRecord

  validates :name, presence: {message: "Name cannot be empty"}, uniqueness: {message: "Team name already taken"}

end
