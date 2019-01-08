class Section < ApplicationRecord
  belongs_to :course, dependent: :destroy, touch: true #, :admin
  has_many :projects
  #has_many :student, :moderator
  
  validates_presence_of :number
  
  validates_numericality_of :number, only_integer: true
  
  validates_inclusion_of :number, in: 1..9999
  
  validates_uniqueness_of :number
  
end
