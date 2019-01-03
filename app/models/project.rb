class Project < ApplicationRecord
  has_many :teams
  
  validates_presence_of :name, :description, :students_rated, :total_interest
  
  validates_length_of :name, :maximum => 60
  validates_length_of :description, :maximum => 65535
  
  #validates_numericality_of :students_rated, :only_integer
  #validates_numericality_of :total_interest, :only_integer
  
end
