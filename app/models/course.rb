class Course < ApplicationRecord
  has_many :sections
  has_many :projects, through: :sections
  
  VALID_CODE_REGEX = /^[a-z]{3,4}-\d{3,4}$/i
  
  validates_presence_of :name, :code, :description
  validates_uniqueness_of :code
  
  validates_length_of :name, maximum: 150
  
  validates_format_of :code, :with => VALID_CODE_REGEX, :on => :create, :multiline => true
  validates_format_of :code, :with => VALID_CODE_REGEX, :on => :update, :multiline => true
  
  validates_length_of :description, maximum: 11*250
end
