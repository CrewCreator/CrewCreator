class Instructor < ApplicationRecord
  has_and_belongs_to_many :sections
  
  before_save {email.downcase!}
  
  validates_with EmailUniquenessValidator

  validates_presence_of :name, :email, :password
  
  validates_length_of :name , maximum: 50
  validates_length_of :email , maximum: 255
  
  validates_format_of :email, :with => VALID_EMAIL_REGEX, :on => :create
  validates_format_of :email, :with => VALID_EMAIL_REGEX, :on => :update
  
  has_secure_password
  validates_length_of :password , minimum: 8
  validates_format_of :password, :with => PASSWORD_FORMAT, :on => :create
  validates_format_of :password, :with => PASSWORD_FORMAT, :on => :update
  
  def Instructor.names
    names = []
    Instructor.all.each do |instructor|
      names << instructor.name
    end
    names
  end
end
