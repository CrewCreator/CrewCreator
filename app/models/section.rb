class Section < ApplicationRecord
  #belongs_to :course
  validates_presence_of :number
end
