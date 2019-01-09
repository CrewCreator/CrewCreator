class CoursesController < ApplicationController
  before_action :is_admin, only: [:new, :create]
  
  def index
    @courses = Course.all
  end
  
  def edit
    id = params[:id]
    @course = Course.find(id)
  end
  
  def new
      @course = Course.new
      @section = Section.new
  end
  
  def create
    @course = Course.new(course_params)
    @section = @course.sections.build(section_params)
    
    #autosave forced section to be saved
    if @course.save
      flash[:notice] = "#{@course.code} -- #{@course.name} was successfully created with sections#{params[:section]}"
      redirect_to courses_path
    else
      render new_course_path
    end
  end
  
  private def course_params 
    params.require(:course).permit(:name, :code, :description)
  end
  
  private def section_params
    params.require(:section).permit(:number)
  end
end
