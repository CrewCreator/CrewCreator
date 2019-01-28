class Student < ApplicationRecord
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    PASSWORD_FORMAT = /\A
                      (?=.*\d)           # Must contain a digit
                      (?=.*[[:^alnum:]]) # Must contain a symbol
                    /x
    
    before_save {email.downcase!}
    
    validates_with EmailUniquenessValidator

    validates_presence_of :name, :email, :password
    
    validates_length_of :name , maximum: 50
    validates_length_of :email , maximum: 255
    
    validates_format_of :email, :with => VALID_EMAIL_REGEX, :on => :create
    validates_format_of :email, :with => VALID_EMAIL_REGEX, :on => :update
    
    validates_uniqueness_of :email
    
    has_secure_password
    validates_length_of :password , minimum: 8
    validates_format_of :password, :with => PASSWORD_FORMAT, :on => :create
    validates_format_of :password, :with => PASSWORD_FORMAT, :on => :update
end
