class Email < ApplicationRecord
  has_and_belongs_to_many :sections

  validates_length_of :email , maximum: 255
  
  validates_uniqueness_of :email

  validates_format_of :email, with: VALID_EMAIL_REGEX, on: :create
  validates_format_of :email, with: VALID_EMAIL_REGEX, on: :update
end
