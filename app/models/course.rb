class Course < ApplicationRecord
  has_many :sections
  #has_many :projects, through: :sections
  validates_presence_of :name, :code, :description
  validates_uniqueness_of :code
end
