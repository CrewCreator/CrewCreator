class Admin < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    before_save {email.downcase!}
    
    #has_many :sections

    validates_presence_of :name, :email, :password
    
    validates_length_of :name , maximum: 50
    validates_length_of :email , maximum: 255
    
    validates_format_of :email, :with => VALID_EMAIL_REGEX, :on => :create
    
    validates_uniqueness_of :email
    
    has_secure_password
    validates_length_of :password , minimum: 8
end
