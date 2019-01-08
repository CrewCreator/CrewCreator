class CoursesController < ApplicationController
  before_action :is_admin, only: [:new, :create]
  
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
    @course = Course.new(course_params)
    if @course.save
      sections_added = ""
      @section = @course.sections.build(section_params)
      
      if @section.save
        sections_added += "#{params[:section]} "
      else
        render new_course_path
        return
      end

      puts(params)
      flash[:notice] = "#{@course.code} -- #{@course.name} was successfully created with sections#{sections_added}"
      redirect_to courses_path
    else
        render new_course_path
      end
    end
  end
  
  private def course_params 
    params.require(:course).permit(:name, :code, :description)
  end
  
  private def section_params
    params.require(:section).permit(:number)
  end
end
