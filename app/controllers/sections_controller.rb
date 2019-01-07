class SectionsController < ApplicationController
  
  def new
    @section = Section.new
  end 
  
  def show
    id = params[:id]
    @section = Section.find(id)
  end
  
  def index 
    @sections = Section.all
  end 
  
end
