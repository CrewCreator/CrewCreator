class ProjectsController < ApplicationController
  before_action :is_admin, only: [:new , :create]
  before_action :find_section, only: [:index, :new, :create]
  before_action :find_project, only: [:new_skill, :create_skill]
  
  def index
    @projects = @section.projects
  end
  
  def new
    @project = Project.new
    @project.skills.build
  end
  
  def create
    @project = @section.projects.build(project_params)
    @project.students_rated = 0
    @project.total_interest = 0
    if @project.save
      redirect_to section_projects_path
    else
      render 'new'
    end
  end
  
  def new_skill
    @skill = @project.skills.build
  end
  
  def create_skill
    @skill = @project.skills.build(skill_params)
    if Skill.exists?(name: @skill.name)
      if @project.skills << Skill.where(name: @skill.name) 
        redirect_to section_projects_path(@project.section)
      else
        render 'new_skill'
      end
    else
      if @skill.save 
        redirect_to section_projects_path(@project.section)
      else
        render 'new_skill'
      end
    end
  end

  private def project_params
    params.require(:project).permit(:name, :description, :difficulty, 
                                    skills_attributes: [:name, :description])
  end
  
  private def skill_params
    params.require(:skill).permit(:name, :description)
  end
  
  private def find_section
    @section = Section.find(params[:section_id])
  end
  
  private def find_project
    @project = Project.find(params[:project_id])
  end
end
