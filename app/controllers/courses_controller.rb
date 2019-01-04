class CoursesController < ApplicationController
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
    @course = Course.create!(params.require(:course).permit(:name, :code, :description))
    flash[:notice] = "#{@course.name} was successfully created."
    redirect_to courses_path
  end
end
