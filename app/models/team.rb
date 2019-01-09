class Team < ApplicationRecord

  # VALID_URL_REGEX = /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix
  VALID_URL_REGEX = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix

  validates_presence_of :name, :description
  validates_length_of :description, minimum: 30
  validates_length_of :description, maximum: 500

  validates_format_of :staging_link, :with => VALID_URL_REGEX, :on => :create
  validates_format_of :production_link, :with => VALID_URL_REGEX, :on => :create
  validates_format_of :version_control_link, :with => VALID_URL_REGEX, :on => :create
  validates_format_of :project_management_link, :with => VALID_URL_REGEX, :on => :create


end
