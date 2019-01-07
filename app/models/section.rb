class Section < ApplicationRecord
  #belongs_to :course
  validates_presence_of :number
  
  validates_numericality_of :number
  
  validates_inclusion_of :number, in: 1..9999
  
  validates_uniqueness_of :number
  
end
