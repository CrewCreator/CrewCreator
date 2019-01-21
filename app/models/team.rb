class Team < ApplicationRecord
  belongs_to :project
  
  validates_presence_of :name, :version_control_link, :production_link,
                        :management_link, :scrum_location, :scrum_time
  
  validates_length_of :name, :maximum => 60
  validates_length_of :version_control_link, :maximum => 256
  validates_length_of :production_link, :maximum => 256
  validates_length_of :management_link, :maximum => 256
  validates_length_of :scrum_location, :maximum => 60
end
