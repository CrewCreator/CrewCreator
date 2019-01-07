class Section < ApplicationRecord
<<<<<<< HEAD
    has_many :projects, :moderators, :students
    belongs_to :course, :admin
    validates_presence_of :number
=======
  #belongs_to :course
  validates_presence_of :number
>>>>>>> staging
end
