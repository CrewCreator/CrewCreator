class Course < ApplicationRecord
  has_many :sections
  validates_presence_of :name, :code, :description
  ''' initialize(name, code)
    @name = name
    @code = code
    @description = ""
  end'''
end
