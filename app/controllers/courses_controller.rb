class CoursesController < ApplicationController
  #Add authentication step
  before_action :is_admin, only: [:new]
  
  def index
    @courses = Course.all
  end
  
  def show
    id = params[:id]
    @course = Course.find(id)
  end
  
  def new
      @course = Course.new
  end
  
  def create
    @course = Course.create(params.require(:course).permit(:name, :code, :description)) #needs to check for uniqueness
    if @course.save
      sections = ["200", "501", "502", "503", "505", "506"]
      sections.each do |section|
        if params[section.to_sym]
          @course.sections.create(params.require(section.to_sym).permit(section.to_sym))
        end
      end
      flash[:notice] = "#{@course.code} -- #{@course.name} was successfully created."
      redirect_to courses_path
    elsif
      render "/courses/new" #add warnings for required fields
    end
  end
end
