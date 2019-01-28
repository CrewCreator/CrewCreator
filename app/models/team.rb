class Team < ApplicationRecord
  belongs_to :project
  #has_and_belongs_to_many :students
  
  validates_presence_of :name
  
  validates_length_of :name, :maximum => 60
  validates_length_of :version_control_link, :maximum => 256
  validates_length_of :production_link, :maximum => 256
  validates_length_of :management_link, :maximum => 256
  validates_length_of :scrum_location, :maximum => 60
  
  validates_format_of :version_control_link, with: URI::regexp(%w(http https)), allow_blank: true
  validates_format_of :production_link, with: URI::regexp(%w(http https)), allow_blank: true
  validates_format_of :management_link, with: URI::regexp(%w(http https)), allow_blank: true
end
