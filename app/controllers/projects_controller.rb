class ProjectsController < ApplicationController
  before_action :super_access, only: [:new, :create, :edit, :update, :remove, :destroy]
  before_action :find_section, only: [:new, :create]
  before_action :find_project, only: [:edit, :update, :remove, :destroy]
  
  def index
    @section = Section.find_by_id(params[:section_id])
    @projects = @section.projects
  end
  
  def new
    if session[:form_values]
      @project = prepare_project(Project.new)
    else
      @project = Project.new
    end
  end
  
  def edit
    @project = find_project
    if session[:form_values]
      @project = prepare_project(Project.find(params[:id]))
    end
  end
  
  def create
    if params[:commit] == "Add Skill"
      handle_add_skill
    else
      @project = @section.projects.build(project_params)
      @project.students_rated = 0
      @project.total_interest = 0
      if @project.save
        redirect_to section_projects_path
      else
        render 'new'
      end
    end
  end
  
  def update
    if params[:commit] == "Add Skill"
      handle_add_skill
    else
      @project = find_project
      if @project.update_attributes(project_params)
        flash[:notice] = "#{@project.name} was successfully updated."
        redirect_to section_projects_path(@project.section)
      else
        render 'edit'
      end
    end
  end
  
  def remove
    @project = find_project
  end
  
  def destroy
    if session[:user] == "admin"
      removed_project = Project.find_by_id(params[:admin][:id])
      check = Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
    elsif session[:user] == "instructor"
      removed_project = find_project(params[:instructor][:id])
      check = Instructor.find_by_id(session[:user_id]).try(:authenticate, params[:instructor][:password])
    else
      flash[:warning] = "Unauthorized action"
      redirect_to new_session_path
    end
    
    if check
      flash[:notice] = "#{removed_project.name} was successfully deleted."
      removed_project.destroy
      redirect_to section_projects_path(removed_project.section)
    else
      flash[:notice] = "Incorrect Password!"
      redirect_to :action => 'remove', :id => params[:id] , :method => :get
    end
  end
  
  private def project_params
    params.require(:project).permit(:name, :description, :difficulty, skill_ids: [])
  end
  
  private def find_section
    id = params[:section_id]
  
    if is_instructor_html
      @section = Instructor.find_by_id(session[:user_id]).sections.find_by_id(id)
      if @section == nil
        flash[:warning] = "Unauthorized action"
        redirect_to new_session_path
      end
    else
      @section = Section.find(id)
    end
    return @section
  end
  
  private def find_project(id=params[:id])
    if is_instructor_html
      @project = Project.find_by_id(id)
      if Instructor.find_by_id(session[:user_id]).sections.find_by_id(@project.section.id) == nil
        flash[:warning] = "Unauthorized action"
        redirect_to new_session_path
      end
    else
      @project = Project.find_by_id(id)
    end
    return @project
  end
  
  #Handles intercept and paramater save for adding a skill
  private def handle_add_skill
      session[:form_values] = params
      session[:project_id] = params[:id]
      session[:return_path] = params[:_method]
      session[:return_section] = params[:section_id]
      redirect_to new_skill_path
  end
  
  private def prepare_project(project)
    project.name = session[:form_values]['project']['name']
    project.description = session[:form_values]['project']['description']
    project.difficulty = session[:form_values]['project']['difficulty']
    project.skill_ids = session[:form_values]['project']['skill_ids']
      session[:form_values] = nil
      session[:project_id] = nil
      session[:return_path] = nil
      session[:return_section] = nil
    return project
  end
  
end
