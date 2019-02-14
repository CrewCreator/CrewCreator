class TeamsController < ApplicationController
  before_action :super_access, only: [:new , :create, :remove, :destroy]
  before_action :find_project, only: [:new, :create]
  
  def index
    if is_instructor_html
      @section = Instructor.find_by_id(session[:user_id]).sections.find_by_id(params[:section_id])
      if @section == nil
        flash[:warning] = "Unauthorized action"
        redirect_to new_session_path
      end
    else
      @section = Section.find(params[:section_id])
    end
    @teams = @section.teams
  end
  
  def show
    @team = Team.find(params[:id])
  end
  
  def new
    @team = Team.new
  end
  
  def edit
    @team = Team.find(params[:id])
    is_admin_or_student_on_team(@team)
  end
  
  def create
    @team = @project.teams.build(team_params)
    if @team.save
      redirect_to section_projects_path(section_id: @project.section)
    else
      render 'new'
    end
  end
  
  def update
    @team = Team.find(params[:id])
    is_admin_or_student_on_team(@team)
    if @team.update_attributes(team_params)
      flash[:notice] = "#{@team.name} was successfully updated."
      redirect_to team_path
    else
      render 'edit'
    end
  end
  
  def remove
    @team = Team.find_by_id(params[:id])
  end
  
  def destroy
    if session[:user] == "admin"
      removed_team = Team.find_by_id(params[:admin][:id])
      check = Admin.find_by_id(session[:user_id]).try(:authenticate, params[:admin][:password])
    elsif session[:user] == "instructor"
      removed_team = Team.find_by_id(params[:instructor][:id])
      check = Instructor.find_by_id(session[:user_id]).try(:authenticate, params[:instructor][:password])
    else
      flash[:warning] = "Unauthorized action"
      redirect_to home_path
    end
    
    if check
      flash[:notice] = "#{removed_team.name} was successfully deleted."
      removed_team.destroy
      redirect_to section_projects_path(removed_team.project.section)
    else
      flash[:warning] = "Incorrect Password!"
      redirect_to remove_team_path(removed_team)
    end
  end
  
  private def team_params
    params.require(:team).permit(:name, :version_control_link,
      :production_link, :management_link, :scrum_location, :scrum_time, student_ids: [])
  end
  
  private def student_params
    params.require(:team).permit(student_ids: [])
  end
  
  private def find_project
    @project = Project.find(params[:project_id])
  end
  
  private def is_admin_or_student_on_team(team)
    unless is_student_on_team(current_user, team) || super_access_html
      redirect_to new_session_path
    end
  end
end
