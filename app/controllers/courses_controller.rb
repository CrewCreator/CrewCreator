class CoursesController < ApplicationController
  before_action :is_admin, only: [:new, :create, :edit, :update, :remove, :destroy]
  
  def index
    @courses = Course.all
  end
  
  def new
    @course = Course.new
  end
  
  def create
    @course = Course.new(course_params)
    
    if @course.save
      flash[:notice] = "#{@course.code} -- #{@course.name} was successfully created!"
      redirect_to courses_path
    else
      render new_course_path
    end
  end
  
  def edit
    id = params[:id]
    @course = Course.find(id)
  end
  
  def update
    id = params[:id]
    @course = Course.find(id)
    if @current_user = Admin.find_by_id(session[:user_id]).try(:authenticate, params[:course][:password])
      if @course.update_attributes(course_params)
        flash[:notice] = "#{@course.code} : #{@course.name} was successfully updated."
        redirect_to :action => 'index'
      else
        flash[:warning] = "Failed to save update. Check your inputs!"
        redirect_to edit_course_path(@course)
      end
    else
      flash[:warning] = "Incorrect Password!"
      redirect_to :action => 'edit', :id => params[:id] , :method => :get
    end
  end
  
  def remove
    id = params[:id]
    @course = Course.find(id)
  end
  
  def destroy
    removed_course = Course.find_by_id(params[:admin][:id])
    if Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      flash[:notice] = "#{removed_course.code} -- #{removed_course.name} was successfully deleted."
      removed_course.destroy
      redirect_to  courses_path
    else
      flash[:warning] = "Incorrect Password!"
      redirect_to :action => 'remove', :id => params[:id] , :method => :get
    end
  end
  
  private def course_params 
    params.require(:course).permit(:name, :code, :description)
  end
end
