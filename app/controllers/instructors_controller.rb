class InstructorsController < ApplicationController
  before_action :is_admin, only: [:create, :new, :remove, :destroy]
    
  def index
    @instructors = Instructors.all
  end
  
  def new
     @instructor = Instructors.new
  end
end
