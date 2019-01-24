class Section < ApplicationRecord
  belongs_to :course, touch: true, validate: true, autosave: true
  #belongs_to :admin
  has_many :projects, dependent: :delete_all
  #has_many :student, :moderator
  
  validates_presence_of :number, :semester, :year
  
  validates_numericality_of :number, :year, only_integer: true
  
  validates_inclusion_of :number, :year, in: 1..9999
  
  validates_uniqueness_of :number, :scope => [:semester, :year]
  
  def method_missing(m, *args, &block)
    if m.to_s=="name"
      self.send("number")
    else
      super
    end
  end 
  
end
