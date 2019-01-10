class SectionsController < ApplicationController
  before_action :is_admin, only: [:new , :create, :edit, :update, :remove, :destroy]
  
  def new
    @course = Course.find(params[:course_id])
    @section = @course.sections.new
  end
  
  def show
    id = params[:id]
    @section = Section.find(id)
  end
  
  def index 
    @sections = Section.all
  end 
  
  def create
    @course = Course.find(params[:course_id])
    @section = @course.sections.build(section_params)
    if @section.save
      redirect_to courses_path
    else
      render 'new'
    end
  end
  
  def edit
    id = params[:id]
    @section = Section.find(id)
  end
  
  def update
    id = params[:id]
    @section = Section.find(id)
    if @section.update_attributes(section_params)
      flash[:notice] = "Section #{@section.number} was successfully updated."
      redirect_to section_projects_path(@section)
    else
      flash[:notice] = "Failed to save update. Check your inputs!"
      redirect_to edit_section_path(@section)
    end
  end
  
  def remove 
    id = params[:id]
    @section = Section.find(id)
  end
  
  def destroy 
    removed_section = Section.find_by_id(params[:admin][:id])
    if Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
      flash[:notice] = "#{removed_section.number} was successfully deleted."
      removed_section.destroy
      redirect_to courses_path
    else
      flash[:notice] = "Incorrect Password!"
      redirect_to :action => 'remove', :id => params[:id], :method => :get
    end 
  end 
  
  private def section_params
    params.require(:section).permit(:number)
  end
end
