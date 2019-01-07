class Section < ApplicationRecord
  belongs_to :course #, :admin
  #has_many :student, :moderator, :project
  
  
  validates_presence_of :number
  
  validates_numericality_of :number, only_integer: true
  
  validates_inclusion_of :number, in: 1..9999
  
  validates_uniqueness_of :number
  
end
