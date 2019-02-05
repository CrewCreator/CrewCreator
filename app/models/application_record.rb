class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_FORMAT = /\A
                    (?=.*\d)           # Must contain a digit
                    (?=.*[[:^alnum:]]) # Must contain a symbol
                  /x

end
