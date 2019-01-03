class Section < ApplicationRecord
  '''has_many :projects, :moderators, :students
  belongs_to :course, :admin'''
  validates_presence_of :course, :number, :projects, 
                        :moderators, :students, :admin
end
