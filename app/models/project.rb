class Project < ApplicationRecord
  validates_presence_of :name, :description, :students_rated, :total_interest
end
