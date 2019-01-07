class CoursesController < ApplicationController
  
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
    @course = Course.create(params.require(:course).permit(:name, :code, :description))
    
    if @course.save
      flash[:notice] = "#{@course.code} -- #{@course.name} was successfully created."
      redirect_to courses_path
    elsif
      render new_courses_path #add arnings for required fields
    end
  end
end
