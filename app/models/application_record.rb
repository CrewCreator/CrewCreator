class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end
