class Section < ApplicationRecord
  #belongs_to :course
  validates_presence_of :number
  
  validates_length_of :number, maximum: 4
  
  validates_numericality_of :number
end
