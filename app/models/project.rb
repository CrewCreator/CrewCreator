class Project < ApplicationRecord
  has_many :teams
  
  validates_presence_of :name, :description, :students_rated, :total_interest
  
  validates_length_of :name, :maximum => 60
  validates_length_of :description, 
  
  
end
