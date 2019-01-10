class Project < ApplicationRecord
  belongs_to :section
  has_and_belongs_to_many :skills
  accepts_nested_attributes_for :skills
  #has_many :teams
  
  validates_presence_of :name, :description, :difficulty, :students_rated, :total_interest
  
  validates_length_of :name, :maximum => 60
  validates_length_of :description, :maximum => 65535
  
  validates_numericality_of :difficulty, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true
  validates_numericality_of :students_rated, only_integer: true
  validates_numericality_of :total_interest, only_integer: true
  
  def Project.difficulties
    [1, 2, 3, 4 , 5]
  end
end
