class Project < ApplicationRecord
  belongs_to :course
  validates_presence_of :name, :description, :students_rated, :total_interest
end
